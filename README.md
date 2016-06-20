# pinboard

Make file configs.yml:
```
db:
    host: localhost
    name: pinba
    user: user
    pass: password
base_url: /
logging:
    long_request_time:
        global: !!float 1
    heavy_request:
        global: 30000
    heavy_cpu_request:
        global: 1
locale: en
cache: apc
records_lifetime: P1M
aggregation_period: PT15M
pagination:
    row_per_page: 50
secure:
    enable: false
```

Now you can to run docker container:
```
docker run -d \
--name pinboard \
--net=host \
-v config/parameters.yml:/server/config/parameters.yml \
-v $(pwd)/php.ini:/etc/php5/fpm/conf.d/99-custom.ini:ro \
-v $(pwd)/fpm-pool.conf:/etc/php5/fpm/pool.d/www.conf:ro \
lebnik/pinboard
```
