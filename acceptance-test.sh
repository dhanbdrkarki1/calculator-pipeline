#!/bin/bash
set -x
test $(curl localhost:8765/sum?a=1\&b=2) -eq 3





# NODE_IP=$(kubectl get nodes -o jsonpath='{ $.items[0].status.addresses[?(@.type=="ExternalIP")].address }')
# NODE_PORT=$(kubectl get svc calculator-service -o=jsonpath='{.spec.ports[0].nodePort}')
# ./gradlew acceptanceTest -Dcalculator.url=http://${NODE_IP}:${NODE_PORT}