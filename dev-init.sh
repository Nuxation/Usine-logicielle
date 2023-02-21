sudo apt update && sudo apt full-upgrade -y && sudo apt-get install maven git vim -y
git config --global user.email "noemail@example.com"
git config --global user.name "GK-Quentin"
git clone https://github.com/Nuxation/webapp-usine.git
cd usine-logicielle/
mvn install
docker image build -t webapp .
docker container run --name server -d -p 8888:8080 webapp