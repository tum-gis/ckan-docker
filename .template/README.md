# Templating this repo

1. Adapt the metadata _labels_ of the Docker images in the `docker/metadata-action`

  ```yaml
  # ...
  # ...
  - name: Extract metadata (tags, labels) for devel docker image
    id: meta
    uses: docker/metadata-action@v5
    with:
      images: |
        ${{ env.REGISTRY }}/tum-gis/ckan-${{ matrix.context }}
      tags: |
        type=ref,enable=true,event=branch
      labels: |
        maintainer=Chair of Geoinformatics, Technical University of Munich (TUM)
        org.opencontainers.image.vendor=Chair of Geoinformatics, Technical University of Munich (TUM)
        org.opencontainers.image.title=ckan-sddi-base-docker-devel
        org.opencontainers.image.documentation=https://github.com/tum-gis/ckan-docker
  # ...
  # ...
  ```
