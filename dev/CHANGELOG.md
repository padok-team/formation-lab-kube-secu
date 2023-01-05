# Changelog

## v4.5.12 to v4.8.3

- [Changed]: Update Argo CD to v2.3.4
- [Fixed]: ApplicationSet and Notification controller Pods now also respect 'global.podAnnotations'
- [Changed]: All metrics Service ports were renamed from 'metrics' to 'http-metrics' (istio compatibility)
  
## v4.3 to v4.4

With v4.4, you can configure an external Redis with ArgoCD (eg. a cloud managed service).

To do this, use the `externalRedis` values.

## v4.2 to v4.3

With v4.3, the notification notifier's `service.slack` is no longer configured by default.

## v4.1 to v4.2

With v4.2, you can enable / disable the applicationSet and notifications components.

We decided not to deploy them by default as it won't be used by most projects.

Added to values file:

```yaml
notifications:
  enabled: false
applicationSet:
  enabled: false
```

## v3 to v4

> Updating to chart v4 updates argo from v2.2 to v2.3

With v2.3, ArgoCD Notifications and ApplicationSet are bundled into ArgoCD.

Changelog references:

- <https://github.com/argoproj/argo-helm/tree/master/charts/argo-cd#400-and-above>
- <https://github.com/argoproj/argo-cd/blob/v2.3.0/docs/operator-manual/upgrading/2.2-2.3.md>
