# Install
`pip install hbp_neuromorphic_platform`

# Using `nmpi`
```
import nmpi
c = nmpi.Client( username="<name>", password="xyz123" )
collab_ids = c.my_collabs()
job_id = c.submit_job( source = "/.../.../test.py", platform="SpiNNaker", colab_id="1234" )
c.job_status(job_id)
job = c.get_job(job_id)
```
 # Visualize
 ```
 import pprint as pp
 pp.pprint(job)
 ```
