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

    [![demo discover manifest](https://img.youtube.com/vi/T8i4sV_Gx3A/0.jpg)](https://youtu.be/T8i4sV_Gx3A)
  
  * The `demo-secrets` folder focuses on how sensitive data (e.g., credentials)
    are automatically detected and externalized during discovery.

    [![demo secrets handling](https://img.youtube.com/vi/boYWovcBaLo/0.jpg)](https://youtu.be/boYWovcBaLo)

  * The `demo-discover-generate` focus on a end to end flow: from the Cloud
    Foundry Manifest, to the Discover Manifest and finally uses the `generate`
    subcommand.
    
    [![demo discover and generate](https://img.youtube.com/vi/2JTiKYItenM/0.jpg)](https://youtu.be/2JTiKYItenM)

  * The `demo-live-discover` folder is intended for live discover Cloud Foundry
    application from real environments.
    
    [![demo live discover](https://img.youtube.com/vi/KoA-ixCG_TQ/0.jpg)](https://youtu.be/KoA-ixCG_TQ)

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


