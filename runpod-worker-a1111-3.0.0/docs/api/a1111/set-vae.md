# Set VAE

## Request

```json
{
  "input": {
    "api": {
      "method": "POST",
      "endpoint": "/sdapi/v1/options"
    },
    "payload": {
      "sd_vae": "None"
    }
  }
}
```

### sd_vae values

* "None"
* "Automatic"
* "vae-ft-mse-840000-ema-pruned.safetensors"

## Response

### RUN

```json
{
  "id": "83bbc301-5dcd-4236-9293-a65cdd681858",
  "status": "IN_QUEUE"
}
```

### RUNSYNC

```json
{
  "delayTime": 1176,
  "executionTime": 3037,
  "id": "sync-9c3fedc3-dcb0-4f50-9a25-a15953004cf2",
  "status": "COMPLETED"
}
```