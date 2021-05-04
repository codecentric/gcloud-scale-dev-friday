# Request message generator

Let's generate the message file:

```bash
python message_generator.py
```

Then let's upload the files to the bucket:

```bash
gsutil cp output.txt gs://${PROJECT_ID}-scale/messages/
```
