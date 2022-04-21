# Oracle Cloud-Native DevOps + Kubernetes DB Operator Lab
DevOps for microservices using the Oracle Kubernetes DB Operator to manage database lifecycle through Kubernetes.

With the growing Kubernetes adoption, customers, engineers and DevOps teams have sought ways to manage their cloud resources through automation tools like Kubernetes allowing us to include these resources in development lifecycles and CI/CD pipelines. With the __Oracle Database operator for Kubernetes__ (OraOperator) allows users (DBAs, Developers, DevOps, GitOps teams, etc.) to dynamically do DB operations such provisioning, cloning and patching, etc. through Kubernetes.

## Getting Started



# Lab Guide
## Lab 1 - Building applications on Kubernetes with Database provision through the OraOperator (Setup)
### 1.1 Run scripts
- Creates Kubernetes Cluster and resources through Terraform
- Builds and pushes images to Oracle Container Registry
- Deploys Application to Kubernetes

```bash
./start/setup.sh
```

### 1.2 Install OraOperator
- Installs cert-manager and the Oracle DB operator through a script

```
./start/setup-operator.sh
```

### 1.3 Connect an Oracle Database using the Oracle Database operator for Kubernetes
- Sets up user credentials to authorize requests with Oracle Databases for creating, terminating, etc.
- Provisions either an (1) `Autonomous Database` (2) `Single-Instance Database` (3) or `Sharded`
- Creates a Database wallet with creation of kubernetes secret
```
./start/setup-credentials.sh
```
```bash
# To provision an Autonomous Database
deploy/automation/scripts/autonomous/provision.sh
```

## Lab 2 - Integrating a CI/CD pipeline

### __LAB 2.2__ - Configure Jenkins


### __LAB 2.3__ - Create Test Pipeline
- Pipeline will:
    1. terminate database if it exists
        - retrieve adb ocid
        ```
        kubectl get AutonomousDatabase/autonomousdatabase-sample -o jsonpath='{.spec.details.autonomousDatabaseOCID}'
        ```
        - generate manifest for termination
        - run manifest
    2. recreate database
        - apply new manifest, given compartment id
        - 
    3. create and add schema
    4. add test data
    5. generate secret for the database
    6. run tests
    7. delete database

### __LAB 2.4__ - Make Changes


## Lab 3 - Exporting Log Metrics with Grafana (Observability)

### __LAB 3__ - Observability