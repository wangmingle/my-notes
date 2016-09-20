consul
-----



https://www.consul.io/intro/getting-started/services.html

  echo '{"service": {"name": "web", "tags": ["rails"], "port": 80}}' > web.json

  consul agent -dev -config-dir ~/dev/etc/consul.d


  dig @127.0.0.1 -p 8600 web.service.consul
  dig @127.0.0.1 -p 8600 web.service.consul SRV
  dig @127.0.0.1 -p 8600 rails.web.service.consul

  curl http://localhost:8500/v1/catalog/service/web


consul agent -dev