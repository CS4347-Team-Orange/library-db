# Terraform

The Terraform projects in this system use [Partial Configuration](https://www.terraform.io/language/settings/backends/remote#using-cli-input) of the Terraform Cloud backend.

You can run this snippet to initialize Terraform locally.

```
cp config.remote.tfbackend.tpl config.remote.tfbackend
sed -i "s#TF_ORG#alex4108#g" config.remote.tfbackend
sed -i "s#TF_WORKSPACE#library-${USER}#g" config.remote.tfbackend
sed -i "s#TF_HOST#app.terraform.io#g" config.remote.tfbackend
terraform init -backend-config="config.remote.tfbackend"
```