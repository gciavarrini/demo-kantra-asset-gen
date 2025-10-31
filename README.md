# Demo - Kantra CLI - asset generation

This repository contains a set of demos that clarify the usage of Kantra CLI for
`discover` and `generate` sub-commands.

## Repository structure
This repository contains various self-contained demo scenarios. Each demo is
organized in its own directory with a dedicated demo.sh script that can be
executed directly.

### Available demos

* Discover
  * The `demo-discover-manifest` folder demonstrates how the discovery process
    produces a normalized YAML,`Discovery Manifest`, based on Cloud Foundry
    input.

    **[▶️ Watch demo discover manifest](https://youtu.be/T8i4sV_Gx3A)**

    [![Watch the demo discover manifest](https://img.youtube.com/vi/T8i4sV_Gx3A/hqdefault.jpg)](https://youtu.be/T8i4sV_Gx3A)
   
  * The `demo-secrets` folder focuses on how sensitive data (e.g., credentials)
    are automatically detected and externalized during discovery.

    **[▶️ Watch demo secrets handling](https://youtu.be/boYWovcBaLo)**

    [![demo secrets handling](https://img.youtube.com/vi/boYWovcBaLo/hqdefault.jpg)](https://youtu.be/boYWovcBaLo)

  * The `demo-discover-generate` focus on an end to end flow: from the Cloud
    Foundry Manifest, to the Discover Manifest and finally uses the `generate`
    subcommand.
    
    **[▶️ Watch demo discover and generate](https://youtu.be/2JTiKYItenM)**

    [![demo discover and generate](https://img.youtube.com/vi/2JTiKYItenM/hqdefault.jpg)](https://youtu.be/2JTiKYItenM)

  * The `demo-live-discover` folder is intended for live discover Cloud Foundry
    application from real environments.

    **[▶️ Watch demo live discover video](https://youtu.be/KoA-ixCG_TQ)**
    
    [![demo live discover](https://img.youtube.com/vi/KoA-ixCG_TQ/hqdefault.jpg)](https://youtu.be/KoA-ixCG_TQ)

  * The `demo-org-filtering` demonstrates the organization filtering
    feature for Cloud Foundry discovery, showing how to filter applications
    by organization names, combine org and space filters, and handle various
    edge cases (non-existent orgs/spaces, warnings, etc.).

    **[▶️ Watch demo organization filter video](https://youtu.be/KoA-ixCG_TQ)**

    [![demo organization filter](https://img.youtube.com/vi/4IDPByi5dJU/hqdefault.jpg)](https://youtu.be/4IDPByi5dJU)

## How to run

Navigate to the directory of the demo you'd like to execute, then run:

```bash
./demo.sh
```

### Prerequisite
- `git`
- `gh`
- `diff`
- `colordiff`
- `cf`
- `helm`


