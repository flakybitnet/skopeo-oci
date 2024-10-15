# skopeo-docker

Docker image of Skopeo, a tool to work with remote images registries - retrieving information, images, signing content.

This is a superset of [official images](https://github.com/containers/image_build/tree/main/skopeo).

## Goal

Official image doesn't supply any docker credentials helper.
So, the goal of the project is to provide seamless login experience into cloud container registries such as ECR, GCR, ACR.

## Images

Images are built on top of the official ones and contain [ECR](https://github.com/awslabs/amazon-ecr-credential-helper), 
[GCR](https://github.com/GoogleCloudPlatform/docker-credential-gcr) and [ACR](https://github.com/chrismellard/docker-credential-acr-env) Docker credential helpers.

Images are published in [Quay](https://quay.io/repository/flakybitnet/skopeo), [GHCR](https://github.com/flakybitnet/skopeo-docker/pkgs/container/skopeo), 
[AWS](https://gallery.ecr.aws/flakybitnet/skopeo) and Harbor registries.

## Usage

Usage is not different from [the official images](https://github.com/containers/skopeo) in general.

You can use images from various registries:

```
quay.io/flakybitnet/skopeo
ghcr.io/flakybitnet/skopeo
public.ecr.aws/flakybitnet/skopeo
harbor.flakybit.net/skopeo
```

### Copy to AWS ECR

Let's go through process of copying an image from our Harbor registry to the public AWS ECR.

According to [ECR creds helper](https://github.com/awslabs/amazon-ecr-credential-helper) docs, 
we should supply AWS credentials:

```
$ export AWS_ACCESS_KEY_ID=login
$ export AWS_SECRET_ACCESS_KEY=pass
```

Then we should set up Docker to use credential helper via `.docker/config.json`.
But as we use Skopeo, we will use the similar file named [containers-auth.json](https://www.mankier.com/5/containers-auth.json).
So, make the `~/auth.json` with 

```
{
    "credHelpers": {
        "public.ecr.aws": "ecr-login"
    }
}
```

Then copy the image using mentioned authentication config:

```
$ skopeo copy "docker://harbor.flakybit.net/skopeo/skopeo" "docker://public.ecr.aws/flakybitnet/skopeo" --dest-authfile="~/auth.json"
```

## Source

Source code are available at [Gitea](https://gitea.flakybit.net/flakybit/skopeo-docker) and mirrored to [GitHub](https://github.com/flakybitnet/skopeo-docker).

## Useful links

1. [skopeo doesn't support credsStore in docker/config.json](https://github.com/containers/skopeo/issues/1083)