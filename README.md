# README

### Deployment instructions

Run those commands to run project locally (you need to have docker composer installed)

`docker-compose build`

`docker-compose run web rake db:create db:migrate db:seed`

`docker-compose up`

or use these for newer version of docker (required on M1 macs):

`docker compose build`

`docker compose run web rake db:create db:migrate db:seed`

`docker compose up`

### Testing

To run spec please use

`docker-compose run web rspec spec`

(for M1 macs use)

`docker compose run web rspec spec`

Database seed contains one sample user record for testing purposes:

_**username**_: test123 _**password**_: test123

### Application URL

You app will start on a standard port: [http://0.0.0.0:3000](http://0.0.0.0:3000)
