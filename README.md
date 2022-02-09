## About
An action to run [Ratify](https://github.com/deislabs/ratify) on specified images.

## Usage
Ratify requires a signing certificate and a subject image reference.  Certificates must be present in the action workspace.  The following example shows how to do this by either checking the certificate into the repository or storing it as a Github secret.
``` yaml
jobs:
  ratify_job:
    runs-on: ubuntu-latest
    name: Verify subject
    steps:
      # needed if signing keys are checked into repo
      - name: checkout repo
        id: checkout
        uses: actions/checkout@v2
      - shell: bash
        env:
          SIGNING_CERT: ${{ secrets.SIGNING_CERT }}
        run: |
          echo "$SIGNING_CERT" > cert2.crt
      - name: Ratify verification step
        id: ratify
        uses: deislabs/ratify-action
        with:
          # comma delimited list of signing certificates
          # path relative to action working directory
          verification-certs: '<my-signing-key>.crt,cert2.crt'
          subject: '<myregistry>/<my-image>'
      - name: Get verification results
        run: echo "Verification results are ${{ steps.ratify.outputs.verification }}"
```
