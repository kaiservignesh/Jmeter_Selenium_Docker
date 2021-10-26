Docker build command - docker build . -f Dockerfile -t jmeter5
Docker run command - docker run -v "$PWD/Scripts/":"/mnt/jmeter" jmeter5 -n -t /mnt/jmeter/TestPlan2.jmx
