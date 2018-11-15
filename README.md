Agens Graph Dcoker Image
========================

## 공식 docker image와 차이점 
- github 에서 소스코드를 받아서 build 한다 
- ubuntu 16.04 기반 
- 기본적으로 원격 접속이 가능하도록 설정함 
- 모든것은 container 안에서 (data volumn 포함)

## 기본사용자 / password 
- agens / qwer4321

## build 
- `docker build -t callin/agensgraph:latest  .`

## run 
- `docker run -dt -p 5432:5432 callin/agensgraph`

