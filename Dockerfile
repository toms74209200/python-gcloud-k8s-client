FROM python:3.11-slim-bullseye AS python-install

COPY requirements.txt /tmp/requirements.txt
RUN pip install -U pip && pip install --no-cache-dir -r /tmp/requirements.txt
RUN rm /tmp/requirements.txt

FROM python-install AS gcloud-install

RUN apt-get update \
    && apt-get install -y curl apt-transport-https ca-certificates gnupg \
    && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
    && apt-get update && apt-get install -y google-cloud-sdk google-cloud-sdk-gke-gcloud-auth-plugin \
    && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
