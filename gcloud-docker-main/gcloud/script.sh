#! /bin/bash

############################
#Create VM
############################
gcloud compute instances create csci644-assignment1 \
    --project=csci644-test \
    --zone=us-central1-c \
    --machine-type=e2-micro \
    --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \
    --metadata=enable-osconfig=TRUE \
    --maintenance-policy=MIGRATE \
    --provisioning-model=STANDARD \
    --service-account=174906188849-compute@developer.gserviceaccount.com \
    --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/trace.append \
    --create-disk=auto-delete=yes,boot=yes,device-name=csci644-assignment1,image=projects/debian-cloud/global/images/debian-13-trixie-v20260908,mode=rw,size=10,type=pd-balanced \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --labels=goog-ops-agent-policy=v2-template-1-7-0,goog-ec-src=vm_add-gcloud \
    --reservation-affinity=any \
&& \
printf 'agentsRule:\n  packageState: installed\n  version: latest\ninstanceFilter:\n  inclusionLabels:\n  - labels:\n      goog-ops-agent-policy: v2-template-1-7-0\n' > config.yaml \
&& \
gcloud compute instances ops-agents policies create goog-ops-agent-v2-template-1-7-0-us-central1-c \
    --project=csci644-test \
    --zone=us-central1-c \
    --file=config.yaml \
&& \
gcloud compute resource-policies create snapshot-schedule default-schedule-1 \
    --project=csci644-test \
    --region=us-central1 \
    --max-retention-days=14 \
    --on-source-disk-delete=keep-auto-snapshots \
    --daily-schedule \
    --start-time=19:00 \
&& \
gcloud compute disks add-resource-policies csci644-assignment1 \
    --project=csci644-test \
    --zone=us-central1-c \
    --resource-policies=projects/csci644-test/regions/us-central1/resourcePolicies/default-schedule-1

############################
#Inspect VM
############################

gcloud compute instances describe csci644-assignment1 --zone=us-central1-c

############################
#Create snapshot
############################

gcloud compute snapshots create snapshot \
    --source-disk=csci644-assignment1 \
    --source-disk-zone=us-central1-c 

############################
#Create second VM
############################

gcloud compute instances create csci644-assignment1-b \
    --zone=europe-west1-b \
    --machine-type=e2-micro \
    --create-disk=boot=yes,source-snapshot=snapshot #creating a disk that is the boot disk from the snapshot just created

############################
#Inspect second VM
############################

gcloud compute instances describe csci644-assignment1-b --zone=europe-west1-b

############################
#Stop second VM
############################

gcloud compute instances stop csci644-assignment1-b --zone=europe-west1-b

############################
#Delete Original VM
############################

gcloud compute instances delete csci644-assignment1 --zone=us-central1-c --quiet #flag for no confirmation prompt

############################
