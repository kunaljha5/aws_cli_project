#!/bin/bash

####################################################################################
##
##    AWS CLI MENU DRIVEN SCRIPT TO PERFORM AWS INSTALLATION ON UBUNTU
##     +-------------------------------------------------------------------+
##     |   Date 2018-March-19                                              |
##     |   User Kunal Jha                                                  |
##     |   Tested on Ubuntu Docker Image                                   |
##     |                                                                   |
##     |   This will install python pip aws cli sudo if not present on your|
##     |   system and then prompt user to enter the aws cli details.       |
##     +--------------------------------------------------------------------
##
####################################################################################

check_ubuntu()
{
FLAOUR=$(grep "DISTRIB_ID=" /etc/lsb-release|cut -d'=' -f2)
if [[ $FLAOUR == "Ubuntu" ]]; then
                echo "LINUX IS UBUNTU"
else
                echo "LINUX IS NOT UBUNTU"
                exit 5;
fi

}

check_sudo()
{
type sudo 2>/dev/null 1>/dev/null
RC=$?
if [[ $RC -eq "0" ]];then
                echo "SUDO INSTALLED"
else
                echo "SUDO NOT INSTALLED."
                apt-get update
                apt-get install sudo -y
                
fi;
}

check_flavour()
{

os_type=$(uname)

if [[ $os_type == "Linux" ]]; then
                echo "HOST SYSTEM IS LINUX"
                check_ubuntu
                check_sudo
                check_aws_cli
else
                echo "HOST SYSTEM IS NOT LINUX"
                exit 199
fi


}



check_aws_cli()
{

type aws 2>/dev/null 1>/dev/null
aws_cli=$?

if [[ $aws_cli -eq "0" ]]; then
                echo "AWS CLI IS INSTALLED"
else
                echo "AWS CLI IS NOT INSTALLED"
                check_pip_cli
                pip install awscli --upgrade --user
                ln -s $HOME/.local/bin/aws /bin/aws
                aws configure
                aws --version
                
                RC=$?
                if [[ $RC -eq "0" ]];then
                
                                echo "AWS CLI installed successfully"
                                                
                else
                                echo "AWS CLI could not be installed"
                                exit 127;
                                
                fi
fi
}



check_pip_cli()
{

type pip 2>/dev/null 1>/dev/null
pip_cli=$?

if [[ $pip_cli -eq "0" ]]; then
                echo "PIP CLI IS INSTALLED"
else
                echo "PIP CLI IS NOT INSTALLED";
                check_python_cli
                sudo apt-get install python-pip python-dev build-essential -y
                sudo pip install --upgrade pip 
                sudo pip install --upgrade virtualenv 
                RC=$?
                if [[ $RC -eq "0" ]];then
                
                                echo "PIP CLI installed successfully"
                                                
                else
                                echo "PIP CLI could not be installed"
                                exit 127;
                                
                fi

fi
}


check_python_cli()
{

type python 2>/dev/null 1>/dev/null
python_cli=$?

if [[ $python_cli -eq "0" ]]; then
                echo "PYTHON IS INSTALLED"
else
                echo "PYTHON IS NOT INSTALLED"
                sudo add-apt-repository ppa:jonathonf/python-2.7 -y
                sudo apt-get update -y
                sudo apt-get install python -y
                python -V
                RC=$?
                if [[ $RC -eq "0" ]];then
                
                                echo "PYTHON installed successfully"
                                                
                else
                                echo "PYTHON could not be installed"
                                exit 127;
                                
                fi
fi
}

check_flavour
sleep 5


while true 
do
clear 
echo "

                AWS CLI CONSOLE MENU 
                
                                1. List Regions
                                2. List All Regions Instance
                                3. List All Regions key-pair
                                4. Select Region
                                5. Set Output Format
                                6. Set AWS ACCESS KEY ID
                                7. Set AWS SECRET ACCESS KEY
                                8. List S3 Bucket
                                E. Exit 
                               
                               "
                               
read -p "                       Enter Option: " input

case $input in
                1)
                                aws ec2 describe-regions --output table ;;
                2)
                                aws ec2 describe-instances --filters Name=instance-state-name,Values=running  --output table --region us-east-1 |egrep "running|AvailabilityZone|InstanceId"|tr -d '|' |sed "s|  ||g"|sed "s|InstanceId||g"|sed "s|AvailabilityZone||g" |sed "s|Name||g"|sed "s|^ ||g" |paste - - -
                                aws ec2 describe-instances --filters Name=instance-state-name,Values=running  --output table --region us-east-2 |egrep "running|AvailabilityZone|InstanceId"|tr -d '|' |sed "s|  ||g"|sed "s|InstanceId||g"|sed "s|AvailabilityZone||g" |sed "s|Name||g"|sed "s|^ ||g" |paste - - -
                                aws ec2 describe-instances --filters Name=instance-state-name,Values=running  --output table --region us-west-1 |egrep "running|AvailabilityZone|InstanceId"|tr -d '|' |sed "s|  ||g"|sed "s|InstanceId||g"|sed "s|AvailabilityZone||g" |sed "s|Name||g"|sed "s|^ ||g" |paste - - -
                                aws ec2 describe-instances --filters Name=instance-state-name,Values=running  --output table --region us-west-2 |egrep "running|AvailabilityZone|InstanceId"|tr -d '|' |sed "s|  ||g"|sed "s|InstanceId||g"|sed "s|AvailabilityZone||g" |sed "s|Name||g"|sed "s|^ ||g" |paste - - -
                                aws ec2 describe-instances --filters Name=instance-state-name,Values=running  --output table --region ap-northeast-1 |egrep "running|AvailabilityZone|InstanceId"|tr -d '|' |sed "s|  ||g"|sed "s|InstanceId||g"|sed "s|AvailabilityZone||g" |sed "s|Name||g"|sed "s|^ ||g" |paste - - -
                                aws ec2 describe-instances --filters Name=instance-state-name,Values=running  --output table --region ap-northeast-2 |egrep "running|AvailabilityZone|InstanceId"|tr -d '|' |sed "s|  ||g"|sed "s|InstanceId||g"|sed "s|AvailabilityZone||g" |sed "s|Name||g"|sed "s|^ ||g" |paste - - -
                                aws ec2 describe-instances --filters Name=instance-state-name,Values=running  --output table --region ap-southeast-1 |egrep "running|AvailabilityZone|InstanceId"|tr -d '|' |sed "s|  ||g"|sed "s|InstanceId||g"|sed "s|AvailabilityZone||g" |sed "s|Name||g"|sed "s|^ ||g" |paste - - -
                                aws ec2 describe-instances --filters Name=instance-state-name,Values=running  --output table --region ap-southeast-2 |egrep "running|AvailabilityZone|InstanceId"|tr -d '|' |sed "s|  ||g"|sed "s|InstanceId||g"|sed "s|AvailabilityZone||g" |sed "s|Name||g"|sed "s|^ ||g" |paste - - -
                                aws ec2 describe-instances --filters Name=instance-state-name,Values=running  --output table --region eu-central-1 |egrep "running|AvailabilityZone|InstanceId"|tr -d '|' |sed "s|  ||g"|sed "s|InstanceId||g"|sed "s|AvailabilityZone||g" |sed "s|Name||g"|sed "s|^ ||g" |paste - - -
                                aws ec2 describe-instances --filters Name=instance-state-name,Values=running  --output table --region eu-west-1 |egrep "running|AvailabilityZone|InstanceId"|tr -d '|' |sed "s|  ||g"|sed "s|InstanceId||g"|sed "s|AvailabilityZone||g" |sed "s|Name||g"|sed "s|^ ||g" |paste - - -
                                aws ec2 describe-instances --filters Name=instance-state-name,Values=running  --output table --region eu-west-2 |egrep "running|AvailabilityZone|InstanceId"|tr -d '|' |sed "s|  ||g"|sed "s|InstanceId||g"|sed "s|AvailabilityZone||g" |sed "s|Name||g"|sed "s|^ ||g" |paste - - -
                                aws ec2 describe-instances --filters Name=instance-state-name,Values=running  --output table --region eu-west-3 |egrep "running|AvailabilityZone|InstanceId"|tr -d '|' |sed "s|  ||g"|sed "s|InstanceId||g"|sed "s|AvailabilityZone||g" |sed "s|Name||g"|sed "s|^ ||g" |paste - - -
                                aws ec2 describe-instances --filters Name=instance-state-name,Values=running  --output table --region sa-east-1 |egrep "running|AvailabilityZone|InstanceId"|tr -d '|' |sed "s|  ||g"|sed "s|InstanceId||g"|sed "s|AvailabilityZone||g" |sed "s|Name||g"|sed "s|^ ||g" |paste - - -
                                aws ec2 describe-instances --filters Name=instance-state-name,Values=running  --output table --region ap-south-1 |egrep "running|AvailabilityZone|InstanceId"|tr -d '|' |sed "s|  ||g"|sed "s|InstanceId||g"|sed "s|AvailabilityZone||g" |sed "s|Name||g"|sed "s|^ ||g" |paste - - -;; 
                3)
                                
                                aws ec2 describe-key-pairs --region us-east-1|sed "s|^| us-east-1 \t|g"
                                aws ec2 describe-key-pairs --region us-east-2 |sed "s|^| us-east-2 \t|g"
                                aws ec2 describe-key-pairs --region us-west-1 |sed "s|^| us-west-1 \t|g"
                                aws ec2 describe-key-pairs --region us-west-2 |sed "s|^| us-west-2 \t|g"
                                aws ec2 describe-key-pairs --region ap-northeast-1 |sed "s|^| ap-northeast-1 \t|g"
                                aws ec2 describe-key-pairs --region ap-northeast-2 |sed "s|^| ap-northeast-2 \t|g"
                                aws ec2 describe-key-pairs --region ap-south-1 |sed "s|^| ap-south-1 \t|g"
                                aws ec2 describe-key-pairs --region ap-southeast-1 |sed "s|^| ap-southeast-1 \t|g"
                                aws ec2 describe-key-pairs --region ap-southeast-2 |sed "s|^| ap-southeast-2 \t|g"
                                aws ec2 describe-key-pairs --region eu-central-1 |sed "s|^| eu-central-1 \t|g"
                                aws ec2 describe-key-pairs --region eu-west-1 |sed "s|^| eu-west-1 \t|g"
                                aws ec2 describe-key-pairs --region eu-west-2 |sed "s|^| eu-west-2 \t|g"
                                aws ec2 describe-key-pairs --region eu-west-3 |sed "s|^| eu-west-3 \t|g"
                                aws ec2 describe-key-pairs --region sa-east-1 |sed "s|^| sa-east-1 \t|g";;
                                
                4)
                                aws ec2 describe-regions --output text| awk '{print $NF}'|nl
                                
                                read -p "Enter the Number of your choice: " number
                                
                                region=$(aws ec2 describe-regions --output text| awk '{print $NF}'|nl| awk -v var=$number '{if ($1 == var) print $2}') 
                                
                                sed -i  "s|region = .*|region = $region|g"  $HOME/.aws/config
                                
                                grep "region"  $HOME/.aws/config;;
                                
                5)
                                echo -e "Json\nText\nTable\nNone"|nl
                                
                                read -p "Enter the Number of your choice: " number
                                
                                output=$(echo -e "json\ntext\ntable\nnone"|nl| awk -v var=$number '{if ($1 == var) print $2}') 
                                
                                sed -i  "s|output = .*|output = $output|g"  $HOME/.aws/config
                                
                                grep "output"  $HOME/.aws/config;;
                                
                6)
                                read -p "Enter AWS_ACCESS_KEY_ID : " AWS_ACCESS_KEY_ID
                                
                                sed -i "s|aws_access_key_id = .*|aws_access_key_id = $AWS_ACCESS_KEY_ID|g"   $HOME/.aws/config
                                
                                RC=$?
                                
                                if [[ $RC -eq "0" ]];then
                                
                                                echo "AWS_ACCESS_KEY_ID updated successfully"
                                                
                                else
                                
                                                echo "AWS_ACCESS_KEY_ID counld not be updated"
                                                
                                fi;;
                7)
                                read -p "Enter AWS_SECRET_ACCESS_KEY : " AWS_SECRET_ACCESS_KEY
                                
                                sed -i "s|aws_secret_access_key = .*|aws_secret_access_key = $AWS_SECRET_ACCESS_KEY|g"   $HOME/.aws/credentials
                                
                                RC=$?
                                
                                if [[ $RC -eq "0" ]];then
                                
                                                echo "AWS_SECRET_ACCESS_KEY updated successfully"
                                                
                                else
                                                echo "AWS_SECRET_ACCESS_KEY could not be updated"
                                                
                                fi;;
                8)
                                aws s3 ls --region us-east-1|sed "s|^| us-east-1 \t|g"
                                aws s3 ls --region us-east-2 |sed "s|^| us-east-2 \t|g"
                                aws s3 ls --region us-west-1 |sed "s|^| us-west-1 \t|g"
                                aws s3 ls --region us-west-2 |sed "s|^| us-west-2 \t|g"
                                aws s3 ls --region ap-northeast-1 |sed "s|^| ap-northeast-1 \t|g"
                                aws s3 ls --region ap-northeast-2 |sed "s|^| ap-northeast-2 \t|g"
                                aws s3 ls --region ap-south-1 |sed "s|^| ap-south-1 \t|g"
                                aws s3 ls --region ap-southeast-1 |sed "s|^| ap-southeast-1 \t|g"
                                aws s3 ls --region ap-southeast-2 |sed "s|^| ap-southeast-2 \t|g"
                                aws s3 ls --region eu-central-1 |sed "s|^| eu-central-1 \t|g"
                                aws s3 ls --region eu-west-1 |sed "s|^| eu-west-1 \t|g"
                                aws s3 ls --region eu-west-2 |sed "s|^| eu-west-2 \t|g"
                                aws s3 ls --region eu-west-3 |sed "s|^| eu-west-3 \t|g"
                                aws s3 ls --region sa-east-1 |sed "s|^| sa-east-1 \t|g";;
                                
                E)
                                exit;;
                *)
                                echo "INVALID NUMBER!" ;;


esac
read -p "

                Press Enter Key to continue .." readkey
done
