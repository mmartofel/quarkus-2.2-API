
oc new-app registry.redhat.io/rhel8/postgresql-12:latest --env-file=$1 --name=$2

oc label deployment/$2 app.kubernetes.io/name=postgresql --overwrite
oc label deployment/$2 app.kubernetes.io/component=database --overwrite
oc label deployment/$2 app.kubernetes.io/part-of=ANGULAR_DEMO_APP --overwrite

