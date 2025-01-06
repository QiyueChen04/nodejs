echo "GET / HTML"
curl -X GET http://localhost:5003
echo

echo "AUTH"

echo "Create new user"
echo "POST /auth/register"
token1=$(
  curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"username": "exampleName@gmail.com", "password": "examplePassword"}' \
  -s http://localhost:5003/auth/register | jq -r '.token'
)
echo $token
echo

echo "Successful Login"
echo "POST /auth/login"
token2=$(
  curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"username": "exampleName@gmail.com", "password": "examplePassword"}' \
  -s http://localhost:5003/auth/login | jq -r '.token'
)

echo

echo "Unsuccessful Login, non-existant username"
echo "POST /auth/login"
curl -X POST -H "Content-Type: application/json" -d '{"username": "invalidUserName", "password": "examplePassword"}' -s http://localhost:5003/auth/login | jq
echo

echo "Unsuccessful Login, invalid password"
echo "POST /auth/login"
curl -X POST -H "Content-Type: application/json" -d '{"username": "exampleName@gmail.com", "password": "invalidPassword"}' -s http://localhost:5003/auth/login | jq
echo
