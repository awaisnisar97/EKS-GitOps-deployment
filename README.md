



**Docker Image Optimisation**

Used a three stage Docker build to compile the Memos frontend and Go backend, producing a lightweight Alpine runtime image.

Reduced the final image footprint by **96.9% compared with the Go builder stage**, from 2.96 GB to 92.7 MB, while running the application as a non-root user.