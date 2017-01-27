# pinboard

Add pinboard user to MySQL:
```
CREATE USER 'pinboard'@'localhost' IDENTIFIED BY 'pinboardPassword';
GRANT ALL PRIVILEGES ON pinba.* TO 'pinboard'@'localhost';
FLUSH PRIVILEGES;
```

Correct settings in the sample file:

- parameters.yml


Now you can to run docker container:
```
docker run -d \
--name pinboard \
--net=host \
-w /var/www/pinboard \
-v $(pwd)/parameters.yml:/var/www/pinboard/config/parameters.yml \
vendelev/pinboard:latest
```

Now you can restart nginx and open http://pinboard.local/