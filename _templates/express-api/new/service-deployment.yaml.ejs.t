---
to: ../<%= folderName %>/service-deployment.yaml
---
apiVersion: v1
kind: Service
metadata:
  name: "<%= apiName %>-<%= versionApi %>-svc"
  namespace: "<%= nameSpace %>"
spec:
  type: NodePort
  selector:
    app: "<%= apiName %>-<%= versionApi %>"
  ports:
    - port: 80
      targetPort: 3000
      protocol: TCP

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: "<%= apiName %>-<%= versionApi %>-deployment"
  namespace: "<%= nameSpace %>"
spec:
  replicas: 1
  selector:
    matchLabels:
      app: "<%= apiName %>-<%= versionApi %>"
  template:
    metadata:
      labels:
        app: "<%= apiName %>-<%= versionApi %>"
    spec:
      containers:
      - name: "<%= apiName %>-<%= versionApi %>"
        image: ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/<%= folderName %>:${BUILD_NUMBER}
        imagePullPolicy: Always
        ports:
        - containerPort: 3000
        readinessProbe:
          httpGet:
            path: /healthcheck
            port: 3000
          initialDelaySeconds: 20
          periodSeconds: 2
          successThreshold: 1
          failureThreshold: 15
          timeoutSeconds: 2
        livenessProbe:
          failureThreshold: 5
          httpGet:
            path: /healthcheck
            port: 3000
          initialDelaySeconds: 60
          periodSeconds: 2
          timeoutSeconds: 5
        resources:
          limits:
            memory: 256Mi
            cpu: 250m
          requests:
            memory: 128Mi
            cpu: 125m
        env:
        - name: NODE_ENV
          value: "production"
        - name: HOST
          value: "${HOST}"
        - name: LOG_INFO_ENABLE
          value: "true"
        - name: LOG_WARN_ENABLE
          value: "true"
        - name: LOG_ERROR_ENABLE
          value: "true"
        - name: LOG_AUDIT_ENABLE
          value: "true"
        - name: DB_READ_HOST
          value: "${DB_READ_HOST}"
        - name: DB_WRITE_HOST
          value: "${DB_WRITE_HOST}"
        - name: DB_PORT
          value: "${DB_PORT}"
        - name: DB_DATABASE
          value: "${DB_DATABASE}"
        - name: DB_USER
          value: "${DB_USER}"
        - name: DB_PASSWORD
          value: "${DB_PASSWORD}"