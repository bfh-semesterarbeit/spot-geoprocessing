# Helping to master aws
This document is a cheat sheet to master AWS


## AWS Console

Login: <https://aws.amazon.com/de/console/>


## AWS SPOT
<https://aws.amazon.com/de/ec2/spot/>

### Spot Instanzen für Container Workload
<https://aws.amazon.com/de/ec2/spot/containers-for-less/>

- Up to 70-90% cheaper
- Being able to hande interruption:
  - What would happen when the server would be taken away?
  - Should be possible to replace instance
  - **We are  having a time insesitive workoad**
- There is the possibility to hibernate the instance

Good postition to work with SPOT:
- Scalability
- Disposable ressources
- Automation
- Loosly coupled
- Removing singpe points of failure

### Anwendungsfälle für Spot Instanzen

- Big Data und Analysen
- **Auf Containern ausgeführte Workoads**
- CI/CD und Tests
- Web Services
- Bild und Medienrendering
- High Performance Computing
- **AWS Batch funtioniert auch mit SPOT Instanzen**

### Pricing
- You can see from the above Spot Instance Pricing History graph (available in the EC2 console under Spot Requests)
- Maximaler Preis kann gesetzt werden
- When you pay more, the interruption frequency can be reduced


### Handling interruption
<https://aws.amazon.com/de/blogs/compute/taking-advantage-of-amazon-ec2-spot-instance-interruption-notices/>
- By Amazon CloudWatch Events
- Or by Instance metadata and data service <https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html>

- Can only be retrieved from the instance itself https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html

TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600") \
&& curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/

**you have to use the IP in the example: Not your IP**

**SPOT interruption: **  Scroll down: <https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-interruptions.html>



http://169.254.169.254/latest/meta-data/instance-action
```bash
# stop
{"action": "stop", "time": "2017-09-18T08:22:00Z"}

```


What is AWS Cloud Formation?

# Walktrough launch ec2 and mount efs
<https://docs.aws.amazon.com/efs/latest/ug/wt1-getting-started.html>
