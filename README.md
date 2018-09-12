# kafka-monitoring
Kafka monitoring example using Burrow, Prometheus, Grafana along with ElasticSearch for topic content viewing.


### Step to run kafka monitoring docker environment

* First bring up the whole docker container by running the following command at the root of the project:
```
docker-compose up -d
```

* Verify all the container are up and running:
```
docker-compose ps
```

* Wait for kafka connect to finish starting by looking at its logs:
```
docker logs -f connect
```

* Add the ElasticSearch connector to kafka connect by running the following script shell file:
```
./scripts/connectors/submit_elastic_sink_config.sh
```

* Check kafka connect logs and verify it has correctly added the ES connector:
```
curl localhost:8083/connectors/elasticsearch-ksql2/status
```

* Generate random values to simulate a load on the 'pageviews' topic:
```
docker-compose exec ksql-datagen ksql-datagen quickstart=pageviews format=avro topic=pageviews maxInterval=1000 bootstrap-server=broker:9092 schemaRegistryUrl=http://schema-registry:8081
```
<br>

You should then be able to see the random messages generated coming up into kafka using Kibana and ES dashboard:

* Kibana : http://localhost:5601
* ES: http://localhost:9200/_cat/indices

To monitor kafka, check Prometheus and Grafana dashboard:
* Prometheus: http://localhost:9090/
* Grafana: http://localhost:3000/

