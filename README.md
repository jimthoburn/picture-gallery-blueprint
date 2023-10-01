# Picture Gallery Blueprint _beta_

This is example code for automatically setting up a web site using [Deno](https://deno.land), [Git](https://git-scm.com) and [Docker](https://www.docker.com).

It’s work in progress 🚧

You can use the included [blueprint](https://render.com/docs/infrastructure-as-code) to host this on [Render](https://render.com/).

This works together with a separate [content repository](https://github.com/jimthoburn/picture-gallery) that has tools for building the web site.

The basic steps to get it working are:

1. [Use this template](https://github.com/jimthoburn/picture-gallery-blueprint/generate) to generate a copy of this repository and do the same for the [content repository](https://github.com/jimthoburn/picture-gallery). You may want to make them both private. 🔐
2. Consider editing the included Dockerfile and [render.yaml](render.yaml) file. For example, you can change the region from `oregon` to one that’s closer to you. Another thing to consider is the [disk size](https://render.com/docs/disks).
3. Create a new GitHub account that only has access to your copy of the [content repository](https://github.com/jimthoburn/picture-gallery).
4. Generate a new [SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh) and add it to your new GitHub account.
5. In your Render dashboard, create a new environment group, following the “picture-gallery-settings” example in: https://github.com/jimthoburn/picture-gallery-blueprint/blob/main/render.yaml. For `GIT_REPOSITORY`, enter a value like `username/repository.git`, with the path to your copy of the  [content repository](https://github.com/jimthoburn/picture-gallery). You can use the account and key you created in steps 3 and 4 for the other environment variables and secrets. For the `known_hosts` secret file, you can add GitHub’s [SSH key entries](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints).
6. In your Render dashboard, create a new [blueprint](https://render.com/docs/infrastructure-as-code) using your copy of this repository. A new service will be set up for you automatically.
7. Link the environment group you created in step 4 to your new service. Your service should automatically re-deploy.

[Git Large File Storage](https://git-lfs.github.com/) is configured automatically. This will support usig `git-lfs` if it’s also enabled in your [content repository](https://github.com/jimthoburn/picture-gallery). If you have a lot of image files, you may run into [bandwidth and storage limits on GitHub](https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-storage-and-bandwidth-usage).
