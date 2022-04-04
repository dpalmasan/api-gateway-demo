# Api Gateway demo

This project has my `krakend.json` file to the Blog Post microservice personal project. The microservices used are:

* [TextStat Service](https://github.com/dpalmasan/texstat-service)
* [BlogPost Service](https://github.com/dpalmasan/python-user-posts-microservice)
* [Authentication Service](https://github.com/dpalmasan/python-user-posts-microservice)

# Custom Plugin for Auth Logic

A custom plugin to validate tokens are not revoked is needed. Such a token can be found under `jwt_revoked_checker` directory. While developing the plugin, I ran into the following issue: `plugin was built with a different version of package`. To address this, I had to build `KrakenD` on my machine and run that version of `KrakenD`. I also made sure that libraries and compiling options matched the ones in the `Makefile`.

# Flexible Config

We are using [Flexible Config](https://www.krakend.io/docs/configuration/flexible-config/) to make it easier testing on development or different environments. To check the configuration file is templated correctly, you can run:

```
FC_ENABLE=1 \
FC_OUT=out.json \
FC_SETTINGS="settings/dev" \
FC_TEMPLATES="settings/endpoints" \
krakend check -d -c "krakend.json"
```

There is also the script `build_krakend_json.sh` which does the same and generates evaluated `out.json`. Currently, directory organization is as follows:

```
settings
├── dev
│   └── db.json
├── endpoints
│   └── auth_svc.tmpl
└── prod
    └── db.json
```

Folder `dev` is for development settings, `prod` for production settings, and endpoints folder contains templates to create endpoints. In this manner we decouple the endpoints and development becomes easier.

# JWT Validation

Some of the endpoints might be protected, for more information see [JWT validation](https://www.krakend.io/docs/authorization/jwt-validation/) on `krakend` docs. To create a secret with your `jwks`:

```
kubectl create secret generic jwks -n default --from-file=./jwks.json
```

Create a new deployment using the following command:

```
# To the default namespace
helm \
    --kube-context=minikube \
    upgrade --install --force --recreate-pods \
    api-gateway \
    helm
```

To forward port for development purposes:

```
kubectl port-forward service/krakend-service 7080:8000
```