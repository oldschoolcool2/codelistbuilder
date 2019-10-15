pre-build:
	aws s3 sync --quiet s3://$(BUCKET_NAME)/data data
