# ckan-docker
Docker image for CKAN

# Extensions required for SDDI Catalog

| Extension | Description |
|-----|-------------|
| [Scheming](https://github.com/MarijaKnezevic/ckanext-scheming) | This extension provides a way to configure and share CKAN schemas using a JSON schema description. Custom template snippets for editing and display are also supported.|
| [GroupHierarchy and Hierarchy](https://github.com/ckan/ckanext-hierarchy) | This extension enables tree hierarchyof a organizations and groups.|
| [Datesearch](https://github.com/MarijaKnezevic/ckanext-datesearch) | Provides the ability to search for datasets according to a given time frame. The search includes all datasets, in which the time of validity overlaps in at least one second with the search time frame. |
| [UserAutoAddGroup](https://github.com/tum-gis/ckanext-userautoaddgroup-sddi) | New users are added automatically to the parent groups, which allows them to create datasets linked to these groups. Alls children groups are inherited from the parent groups.|
| [GeoView](https://github.com/pduchesne/ckanext-geoview) | This extension contains view plugins to display geospatial files and services in CKAN.|
| [Composite] (https://github.com/EnviDat/ckanext-composite) | The extension allows to store structured dataset metadata, single or multiple fields. Only one level of subfields is possible. The subfields can be basic text, date type o choice dropboxes. |
| [Restricted] (https://github.com/MarijaKnezevic/ckanext-restricted) | CKAN extension to restrict the accessibility to the resources of a dataset. This way the package metadata is accesible but not the data itself (resource). The resource access restriction level can be individualy defined for every package.|
| [Repeating] (https://github.com/MarijaKnezevic/ckanext-repeating) | This extension provides a way to store repeating fields in CKAN datasets, resources, organizations and groups.|
| [Disqus] (https://github.com/ckan/ckanext-disqus) | The Disqus extension allows site visitors to comment on individual packages using an AJAX-based commenting system. The downsides of this plugin are that comments are not stored locally and user information is not shared between CKAN and the commenting system.|
