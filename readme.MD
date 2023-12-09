# Issue 

136.0 curl: (7) Failed to connect to raw.githubusercontent.com port 443: Connection timed out
136.0 [ Error ] [GHCup-05841] Download failed: Process "curl" with arguments ["--dump-header",
136.0 [ ...   ]                                                 "/tmp/curl-header26-0", "-fL", "-o",
136.0 [ ...   ]                                                 "/root/.ghcup/cache/ghcup-0.0.8.yaml.tmp",
136.0 [ ...   ]                                                 "https://raw.githubusercontent.com/haskell/ghcup-metadata/master/ghcup-0.0.8.yaml"] failed with exit code 7.
136.0 "ghcup --metadata-fetching-mode=Strict upgrade" failed!
------
Dockerfile:27
--------------------
  25 |     
  26 |     #Install GHC
  27 | >>> RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
  28 |     
  29 |     ENV PATH="/root/.ghcup/bin:${PATH}" 
--------------------
ERROR: failed to solve: process "/bin/sh -c curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh" did not complete successfully: exit code: 2

# Probable Cause 
- Failing on Jio 