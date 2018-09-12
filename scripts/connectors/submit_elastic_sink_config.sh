#!/bin/bash

CONNECT_HOST=localhost

if [[ $1 ]];then
    CONNECT_HOST=$1
fi

HEADER="Content-Type: application/json"
DATA=$( cat << EOF
{
  "name": "elasticsearch-ksql2",
  "config": {
    "connector.class": "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",
    "consumer.interceptor.classes": "io.confluent.monitoring.clients.interceptor.MonitoringConsumerInterceptor",
    "topics": "pageviews",
    "topic.index.map": "pageviews:pageviews",
    "connection.url": "http://elasticsearch:9200",
    "type.name": "pageviewschange",
    "key.ignore": true,
    "key.converter": "org.apache.kafka.connect.json.JsonConverter",
    "key.converter.schema.registry.url": "http://schema-registry:8081",
    "key.converter.schemas.enable": false,
    "value.converter": "io.confluent.connect.avro.AvroConverter",
    "value.converter.schema.registry.url": "http://schema-registry:8081",
    "value.converter.schemas.enable": false,
    "schema.ignore": true,
    "schema.enable": false

  }
}
EOF
)

echo "curl -X POST -H \"${HEADER}\" --data \"${DATA}\" http://${CONNECT_HOST}:8083/connectors"
curl -X POST -H "${HEADER}" --data "${DATA}" http://${CONNECT_HOST}:8083/connectors
echo
