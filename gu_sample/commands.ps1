#Install dbt
pip install dbt-snowflake

#check dbt installed
dbt --version

#create dbt project
dbt init gu-sample

#Build docker image with specific target
#docker build -t <img tag>    --target <dbt target>
 docker build -t gu-sf --target dbt-snowflake .

#docker run -p port      --name container name   -v volume             -it image dbt-command         
 docker run -p 8581:8580 --name gu_dbt_container -v "$(pwd)/gu_sample" -it gu-sf run

#login to azure
 az login

#login to acr
 az acr login --name moqacr

#tag docker image to acr
 docker tag gu-sf moqacr.azurecr.io/gu-sf

#push docker image to acr
 docker push moqacr.azurecr.io/gu-sf

 docker run -p 8581:8580 --name dbt_run -v "$(pwd)/gu_sample" -it gu-sf run