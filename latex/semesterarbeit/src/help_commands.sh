# https://docs.aws.amazon.com/secretsmanager/latest/userguide/vpc-endpoint-overview.html
aws ec2 create-vpc-endpoint  --vpc-id vpc-87ad55fe \
                             --vpc-endpoint-type Interface \
                             --service-name com.amazonaws.eu-west-1.secretsmanager \
                             --subnet-ids subnet-f66512ac \
                             --security-group-id sg-098669727548dcedd

#vpc endpoint id
#vpce-006949cd7fb8f6852

vpce-006949cd7fb8f6852-lvvhyjpb-eu-west-1b.secretsmanager.eu-west-1.vpce.amazonaws.com

aws secretsmanager list-secrets --endpoint-url https://vpce-006949cd7fb8f6852-lvvhyjpb-eu-west-1b.secretsmanager.eu-west-1.vpce.amazonaws.com


3d tiles


node --max-old-space-size=20000 node_modules/.bin/roadhouse -i input -o output --clear-normals --face-normals --max-tiles 1000 -r UUID -r DATUM_AENDERUNG -r DATUM_ERSTELLUNG -r ERSTELLUNG_JAHR -r ERSTELLUNG_MONAT -r REVISION_JAHR -r REVISION_MONAT -r GRUND_AENDERUNG -r HERKUNFT -r HERKUNFT_JAHR -r HERKUNFT_MONAT -r OBJEKTART -r ORIGINAL_HERKUNFT -r GEBAEUDE_NUTZUNG -r Longitude -r Latitude -r Height


node --max-old-space-size=20000 node_modules/.bin/roadhouse -i /var/app/input -o /var/app/output -db /var/app/db --clear-normals --face-normals --max-tiles 1000 -r UUID -r DATUM_AENDERUNG -r DATUM_ERSTELLUNG -r ERSTELLUNG_JAHR -r ERSTELLUNG_MONAT -r REVISION_JAHR -r REVISION_MONAT -r GRUND_AENDERUNG -r HERKUNFT -r HERKUNFT_JAHR -r HERKUNFT_MONAT -r OBJEKTART -r ORIGINAL_HERKUNFT -r GEBAEUDE_NUTZUNG -r Longitude -r Latitude -r Height

docker run -it -v /home/ubuntu/data/input/:/var/app/input/ -v /home/ubuntu/data/output/:/var/app/output/ -v /home/ubuntu/data/db:/var/app/db -v /home/ubuntu/data/agi_log/:/var/app/log c6105ce43be3

# yeah:
docker run -it  -m 55G --cpus=15 -v /home/ubuntu/data/input/:/var/app/input/ -v /home/ubuntu/data/output/:/var/app/output/ -v /home/ubuntu/db:/var/app/db c6105ce43be3 /root/.nvm/versions/node/v8.11.2/bin/node --max-old-space-size=20000 /var/app/node_modules/.bin/roadhouse -i /var/app/input -o /var/app/output -db /var/app/db --clear-normals --face-normals --max-tiles 1000 -r UUID -r DATUM_AENDERUNG -r DATUM_ERSTELLUNG -r ERSTELLUNG_JAHR -r ERSTELLUNG_MONAT -r REVISION_JAHR -r REVISION_MONAT -r GRUND_AENDERUNG -r HERKUNFT -r HERKUNFT_JAHR -r HERKUNFT_MONAT -r OBJEKTART -r ORIGINAL_HERKUNFT -r GEBAEUDE_NUTZUNG -r Longitude -r Latitude -r Height
