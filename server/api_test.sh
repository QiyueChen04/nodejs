echo "GET /"
htmlRes=$(curl -X GET -s http://localhost:5003)
if [ -n "$htmlRes" ]; then
  echo "Successful"
else
  echo "Failed"
  echo $htmlRes
  exit 1
fi

echo
echo "AUTH"
echo

echo "Create new user"
echo "POST /auth/register"
token1=$(
  curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"username": "exampleName@gmail.com", "password": "examplePassword"}' \
  -s http://localhost:5003/auth/register \
  | jq -r '.token'
)
if [ -n "$token1" ]; then
  echo "Successful"
else
  echo "Failed"
  echo $token1
  exit 1 
fi 
echo

echo "Valid Login"
echo "POST /auth/login"
token2=$(
  curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"username": "exampleName@gmail.com", "password": "examplePassword"}' \
  -s http://localhost:5003/auth/login \
  | jq -r '.token'
)
if [ "$token1" = "$token2" ]; then
  echo "Successful"
else
  echo "Failed"
  echo "token1 and token2 aren't the same"
  exit 1 
fi 
echo

echo "Unsuccessful Login, non-existant username"
echo "POST /auth/login"
noUserRes=$(
  curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"username": "invalidUserName", "password": "examplePassword"}' \
  -s http://localhost:5003/auth/login \
  | jq -r '.message'
)
if [ "$noUserRes" = "User not found" ]; then
  echo "Successful"
else 
  echo "Failed"
  exit 1 
fi 
echo

echo "Unsuccessful Login, invalid password"
echo "POST /auth/login"
invalidPasswordRes=$(
  curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"username": "exampleName@gmail.com", "password": "invalidPassword"}' \
  -s http://localhost:5003/auth/login \
  | jq -r '.message'
)
if [ "$invalidPasswordRes" = "Invalid password" ]; then
  echo "Successful"
else 
  echo "Failed"
  exit 1
fi 

echo 
echo "Todo"
echo 

echo "Get all todos"
echo "GET /todos"
firstTodoMessage=$(
  curl -X GET \
  -H "Authorization: $token1" \
  -s http://localhost:5003/todos \
  | jq -r '.[0].task'
)
if [ "$firstTodoMessage" = "Hello, please add your first todo" ]; then
  echo "Successful"
else 
  echo "Failed"
  echo "$firstTodoMessage"
  exit 1
fi 
echo 

echo "Add one todo"
echo "POST /todos"
newTask="This is a new task"
newTaskRes=$(
  curl -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: $token1" \
  -d "{\"task\": \"$newTask\"}" \
  -s http://localhost:5003/todos \
  | jq -r '.task'
)
if [ "$newTaskRes" == "$newTask" ]; then
  echo "Successful"
else
  echo "Failed"
  echo "$newTaskRes"
  exit 1
fi 
echo 

