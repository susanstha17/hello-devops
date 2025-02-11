<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechAxis WebApp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

    <!-- Hero Section -->
    <header class="bg-primary text-white text-center py-5">
        <h1>Welcome to TechAxis</h1>
        <p class="lead">Empowering technology education for the future</p>
        <a href="https://techaxis.com.np" target="_blank" class="btn btn-light btn-lg">Visit Our Website</a>
    </header>

    <!-- Content Section -->
    <div class="container mt-5">
        <h2 class="text-center mb-4">Explore Our Offerings</h2>

        <div class="row text-center">
            <div class="col-md-4">
                <div class="card shadow p-4">
                    <h4>DevOps Training</h4>
                    <p>Master CI/CD, Docker, Kubernetes, and automation.</p>
                    <a href="${pageContext.request.contextPath}/hello" class="btn btn-primary">Explore DevOps</a>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card shadow p-4">
                    <h4>DevSecOps</h4>
                    <p>Learn security best practices in development and operations.</p>
                    <a href="${pageContext.request.contextPath}/anotherPage" class="btn btn-secondary">Explore DevSecOps</a>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card shadow p-4">
                    <h4>API Services</h4>
                    <p>Get real-time JSON data with our API.</p>
                    <a href="${pageContext.request.contextPath}/api/data" class="btn btn-success">View API Data</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Call to Action -->
    <section class="text-center my-5">
        <h3>Ready to Transform Your Career?</h3>
        <p>Join our professional courses and get ahead in tech.</p>
        <a href="https://techaxis.com.np/contact" target="_blank" class="btn btn-danger btn-lg">Contact Us</a>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3">
        <p>&copy; 2025 TechAxis. All Rights Reserved.</p>
    </footer>

</body>
</html>
