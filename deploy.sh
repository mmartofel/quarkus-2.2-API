./mvnw clean package \
    -Dquarkus.container-image.build=true \
    -Dquarkus.kubernetes-client.trust-certs=true \
    -DskipTests \
  -Dquarkus.profile=ocp


oc delete all --selector app=backend

oc apply -f ./deployment/angular-demo-app-configmap.yml
oc new-app --name=backend `oc project --short=true`/backend:2.0
oc set env deployment/backend --from configmap/angular-demo-app-configmap
oc expose service/backend

oc label deployment/backend app.kubernetes.io/part-of=ANGULAR_DEMO_APP --overwrite
oc label deployment/backend app.openshift.io/runtime=quarkus --overwrite

echo
echo "Try now to hit your backend service at:"
echo
echo "   http://"`oc get route backend -o template --template='{{ .spec.host }}'` 
echo
echo "Or first check Swagger UI to explore API provided by microservice:"
echo
echo "   http://"`oc get route backend -o template --template='{{ .spec.host }}'`"/q/swagger-ui"
echo

