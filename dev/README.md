# ArgoCD

## Bootstrap

This section explains how to deploy ArgoCD for the first time.

### Context

Our target architecture is for ArgoCD to manage every component deployed in the
cluster, including ArgoCD itself. Once ArgoCD is deployed, it uses the contents
of this repository to deploy everything.

### Requirements

- `helm`
- `kubectl`
- `kubeseal`
- Kubernetes cluster is up, `kubectl get nodes` works

### Instructions

ArgoCD uses an SSH key to connect to its repositories. ArgoCD needs a separate
key for each repository.

The steps below show how to upload ArgoCD's private key to the cluster securely
with Sealed Secrets.

1. Generate public and private keys:

   ```shell
   ssh-keygen -t ed25519 -C "ArgoCD" -f argocd -N ""
   ```

2. Upload the public key (`argocd.pub`) as a Deploy Key in your repository (read-only).

3. Create a `<my_env>/component-config/argocd/templates/secret.yaml` file with ArgoCD's repository's URL and private key:

   > 🚨 Do **NOT** commit this file to git (add it to .gitignore). 🚨

   ```yaml
   apiVersion: v1
   kind: Secret
   metadata:
   name: github-credentials
   labels:
     argocd.argoproj.io/secret-type: repository
   type: Opaque
   stringData:
   # Change this 👇, write your repository URL as `git@...`.
   url: git@github.com:padok-team/your-repository.git
   # Change this 👇, write ArgoCD's private key.
   sshPrivateKey: |
     -----BEGIN OPENSSH PRIVATE KEY-----
     b3Bl...
     -----END OPENSSH PRIVATE KEY-----
   ```

4. Delete the `argocd` and `argocd.pub` ssh key files.

5. Copy these files to your gitops repository.

- `argocd/argo-apps/app-of-apps.yaml` -> `argo-config/applications/app-of-apps.yaml`
- `argocd/argo-apps/argocd.yaml` -> `argo-config/applications/argocd.yaml`
- `sealed-secrets/argo-app.yaml` -> `argo-config/applications/sealed-secrets.yaml`
- `argocd/helm/` -> `component-config/argocd/`

You should have something like this

```plaintext
.
├── README.md
└── my-env
    ├── argocd-config
    │   └── applications
    │       ├── app-of-apps.yml
    │       ├── argocd.yml
    │       └── sealed-secrets.yaml
    └── component-config
        ├── argocd
        │   ├── Chart.yaml
        │   ├── README.md
        │   ├── templates
        │   │   ├── .gitignore
        │   │   ├── github-deploy-key.yaml
        │   │   └── secret.yaml
        │   └── values.yaml
        └── sealed-secrets
            ├── Chart.yaml
            ├── README.md
            └── values.yaml
```

6. Make some mandatory changes to the files you copied. Here are the values that
   need to be changed:

- `argo-config/applications/app-of-apps.yaml`
  - `spec.source.repoURL`
- `argo-config/applications/argocd.yaml`:
  - `spec.source.repoURL`
- `component-config/argocd/values.yaml`:
  - `argo-cd.server.ingress.ingressClassName` _If needed_
  - `argo-cd.server.ingress.hosts`
  - `argo-cd.server.ingress.tls.hosts`
  - `argo-cd.server.ingress.annotations.nginx.ingress.kubernetes.io/auth-url` _If needed_
  - `argo-cd.server.ingress.annotations.nginx.ingress.kubernetes.io/auth-signin` _If needed_

7. Install it with:

```shell
helm install argocd . -n argocd --create-namespace  --dependency-update
```

8. Apply the `app-of-apps.yaml`.

   ```shell
   kubectl apply -f argo-config/applications/app-of-apps.yaml -n argocd
   ```

9. Manage the ArgoCD secret

The secret used is not encrypted, you can't commit it in the repository. To secure your secrets management, you can use several tools :

- [ExternalSecret](../external-secrets/README.md)
- [SealedSecret](../sealed-secret/README.md)

ExternalSecret lets you use the Cloud Provider Secret Manager thanks to a new Kubernetes resource `ExternalSecret`.
SealedSecret is cloud agnostic. It encrypts your secrets with its own certificate managed inside the cluster.

1. We advise you to use one of them, so, to install them you can read the following documentation :

- [Install SealedSecret](../sealed-secret/README.md#implementation)
- [Install ExternalSecret](../external-secrets/README.md#implementation)

2. Transform your secret

Transform your secret into SealedSecret or ExternalSecret depending on your previous choice :

- [Secret to SealedSecret](../sealed-secret/README.md#transform-a-secret-to-a-sealedsecret-resource)
- [Secret to External](../external-secrets/README.md#create-an-externalsecret)

3. Delete the unencrypted secret
   Ensure the SealedSecret or ExternalSecret resource is in `<my_env>/component-config/argocd/templates/` then delete the unencrypted secret.

4. You can now commit your changes !

## Improvements

The following improvements have yet to be made:

- Include the `bootstrap` directory in Padok's Kubernetes framework.
