# oauth-api-server

Provide Simple API server with oauth2.0

## Setup
### Install

```ruby
bundle
bundle exec rake db:migrate
```
### Launch
```ruby
bundle exec rails server -p 5000
```
## Authentication & API Request Flow

### Register your Application
access `oauth/applications` 

![newapp](https://raw.githubusercontent.com/chaingng/images/master/2017-01-06-15.53.58.png)

then register new application

![register](https://raw.githubusercontent.com/chaingng/images/master/2017-01-06-15.54.24.png)

### Authorization
click Authorize button  

![authorizebutton](https://raw.githubusercontent.com/chaingng/images/master/2017-01-06-15.54.31.png)

or Authorize API request

```bash
curl -X GET http://localhost:5000/oauth/authorize \
-F response_type=code \
-F client_id=d6da6ee768631ade98798d9fcc632621acb20e418c46c5bbd7d36f22c4874371 \
-F redirect_uri=http://www.yahoo.co.jp/ \
-F scope=info
```

### Redirect User to Login Page
redirect user to login page

![redirect](https://raw.githubusercontent.com/chaingng/images/master/2017-01-06-18.34.50.png)

### Require authorization
After login or signup, move to require authorization page
![confirmauthorize](https://raw.githubusercontent.com/chaingng/images/master/2017-01-06-15.56.59.png)


If clck Authorize, redirect specified redirect_url with authorization code 

### Token Request

```bash
curl -X POST http://localhost:5000/oauth/token \
-F grant_type=authorization_code \
-F client_id=d6da6ee768631ade98798d9fcc632621acb20e418c46c5bbd7d36f22c4874371 \
-F client_secret=c1c89bcd048923bac21820f7e3653de756b5ba58e94875be2d12db97adfd4274 \
-F code=92c8ab063daec8593a8b6191f4f6b07d0313e9e93ecd1e76b4a160b5069e962b \
-F redirect_uri=http://www.yahoo.co.jp/ \
-F scope=info
```

then, response like this
```bash
{"access_token":"2d1a69418f627ef397285c8a7bf2877e66c4febf709e09fbc958ec3b08b1430e","token_type":"bearer","expires_in":7200,"scope":"info","created_at":1483685928}
```

### API Request
```bash
curl -X GET http://localhost:5000/api/user \
-H "Authorization: Bearer 142107ad12a550595faca319491921d7b358df4e9edddd87ee46a193c7c09f97"
```

then, response like this
```bash
{"id":1,"email":"test@example.com","created_at":"2017-01-06T06:28:46.713Z","updated_at":"2017-01-06T07:11:35.212Z"}
```
