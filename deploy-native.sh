./mvnw clean package \
    -Dquarkus.container-image.build=true \
    -Dquarkus.kubernetes-client.trust-certs=true \
    -DskipTests \
  -Dquarkus.profile=ocp \
  -Dquarkus.native.container-build=true \
  -Pnative \
  --file pom-native.xml


oc delete all --selector app=backend-native

oc new-app --name=backend-native `oc project --short=true`/backend-native:2.0
oc set env deployment/backend-native --from configmap/angular-demo-app-configmap
oc expose service/backend-native

oc label deployment/backend-native app.kubernetes.io/part-of=ANGULAR_DEMO_APP --overwrite
oc label deployment/backend-native app.openshift.io/runtime=quarkus --overwrite

echo
echo "Try now to hit your backend service at:"
echo
echo "   http://"`oc get route backend-native -o template --template='{{ .spec.host }}'` 
echo
echo "Or first check Swagger UI to explore API provided by microservice:"
echo
echo "   http://"`oc get route backend-native -o template --template='{{ .spec.host }}'`"/q/swagger-ui"
echo

