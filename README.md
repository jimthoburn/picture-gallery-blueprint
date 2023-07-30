# Picture Gallery Blueprint _beta_

This is example code for automatically setting up a web site using [Deno](https://deno.land), [Git](https://git-scm.com) and [Docker](https://www.docker.com).

It’s work in progress 🚧

You can use the included [blueprint](https://render.com/docs/infrastructure-as-code) to host this on [Render](https://render.com/).

This works together with a separate [content repository](https://github.com/jimthoburn/picture-gallery) that has tools for building the web site.

The basic steps to get it working are:

1. [Use this template](https://github.com/jimthoburn/picture-gallery-blueprint/generate) to generate a copy of this repository and do the same for the [content repository](https://github.com/jimthoburn/picture-gallery). You may want to make them both private. 🔐
2. Consider editing the included Dockerfile and [render.yaml](render.yaml) file. For example, you can change the region from `oregon` to one that’s closer to you. Another thing to consider is the [disk size](https://render.com/docs/disks).
2. Create a new GitHub account that only has access to your copy of the [content repository](https://github.com/jimthoburn/picture-gallery).
3. Generate a new SSH key and add it to your new GitHub account.
4. In your Render dashboard, create a new environment group, following the “picture-gallery-settings” example in: https://github.com/jimthoburn/picture-gallery-blueprint/blob/main/render.yaml. For `GIT_REPOSITORY`, enter a value like `username/repository.git`, with the path to your copy of the  [content repository](https://github.com/jimthoburn/picture-gallery). You can use the account and key you created in steps 3 and 4 for the other environment variables and secrets. And you can create an empty `known_hosts` secret file, to start out with.
5. In your Render dashboard, create a new [blueprint](https://render.com/docs/infrastructure-as-code) using your copy of this repository.
6. A new service will be set up for you automatically. Link the environment group you created in step 4 to your new service.
7. Once your service is up and running, go to the shell for your service and run the “setup” script: `bash /home/deno/setup.sh`
8. Your picture gallery will be set up in the `~/site` folder.
9. To update your gallery, run the “update” script: `bash /home/deno/update.sh`

The “setup” and “update” scripts will “clone” and “pull” from your [content repository](https://github.com/jimthoburn/picture-gallery), respectively.

After you run the setup script in the shell, a `~/known_hosts` file should be generated. You can copy this to your environment group (see step 5) so it will automatically be available for other instances of your blueprint, like preview environments (to avoid prompts when running setup.sh automatically).

[Git Large File Storage](https://git-lfs.github.com/) is configured automatically. This will support usig `git-lfs` if it’s also enabled in your [content repository](https://github.com/jimthoburn/picture-gallery). If you have a lot of image files, you may run into [bandwidth and storage limits on GitHub](https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-storage-and-bandwidth-usage).
