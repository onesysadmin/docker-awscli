docker-awscli
=============

A docker container that has awscli installed to run.

## Usage

The container is primarily used to launch awscli util to run the `aws` command.  To run it using instance profile credentials (or not providing any credentials), use:

```docker run -i -t --rm onesysadmin/awscli <command> <options>```

Entry point for the container is already set to run aws.

You can attach your AWS credentials using environment variables, but this is not the most secure method since your credentials are shown in the process list:

```docker run -i -t --rm -e AWS_ACCESS_KEY_ID=xxxxxx -e AWS_SECRET_ACCESS_KEY=xxxxx -e AWS_DEFAULT_REGION=us-east-1 onesysadmin/awscli <command> <options>```

Instead, you can attach your AWS Credentials file by mounting it in:

```docker run -i -t --rm -v mycredentialsfile:/root/.aws/credentials:ro onesysadmin/awscli <command> <options>```

Your credential file would look something like this:

```
[default]
aws_access_key_id = your_access_key_id
aws_secret_access_key = your_secret_access_key
```

## Using CLI Config

You can set some default options for your cli command.  This is especially when you don't want to specify the region for every single command.

```
[default]
aws_access_key_id=AKIAIOSFODNN7EXAMPLE
aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
region=us-east-1
output=text
```

If you include the aws crendentials inside the profile, you do not need to add a separate credentials file.  If you do add a separate credentials file, then those credentials will override the ones in the cli config file.

Once you have the config file, you can mount it into the docker image.

```docker run -i -t --rm -v mycliconfig:/root/.aws/config:ro onesysadmin/awscli <command> <options>```

## Creating multiple profiles

To create separate profiles within the config file, you simply specify the name, ie.

```
[default]
aws_access_key_id=AKIAIOSFODNN7EXAMPLE
aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
region=us-east-1
output=text

[profile test-user]
aws_access_key_id=AKIAI44QH8DHBEXAMPLE
aws_secret_access_key=je7MtGbClwBF/2Zp9Utk/h3yCo8nvbEXAMPLEKEY
region=us-west-2
```

You can also match the profile against a separate set of crendentials in the credentials file:

```
[default]
aws_access_key_id = your_access_key_id
aws_secret_access_key = your_secret_access_key

[test-user]
aws_access_key_id=AKIAI44QH8DHBEXAMPLE
aws_secret_access_key=je7MtGbClwBF/2Zp9Utk/h3yCo8nvbEXAMPLEKEY
```

Once the profile is created, you can then use `--profile` switch to use the profile:

```docker run -i -t --rm -v mycliconfig:/root/.aws/config:ro onesysadmin/awscli --profile test-user <command> <options>```

Alternatively, you can set the environment `AWS_DEFAULT_PROFILE`:

```docker run -i -t --rm -v mycliconfig:/root/.aws/config:ro -e AWS_DEFAULT_PROFILE=test-user onesysadmin/awscli <command> <options>```

For more command options, please see [AWS CLI Getting Started documentation](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html).
