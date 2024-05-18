# JOB BOARD

---

## Project Overview

**Job Board** is a web application built with Ruby on Rails and Tailwind CSS. It allows users to create, manage, and apply for job postings. The application supports three types of users: admin, employer, and freelancer, each with specific dashboards and functionalities.

## Features

- User authentication with Devise
- Role-based access control with CanCanCan
- Admin dashboard for managing the site
- Employer dashboard for posting and managing jobs
- Freelancer dashboard for viewing and applying for jobs
- Responsive design with Tailwind CSS

## Versions

- **Ruby**: 3.0.6
- **Rails**: 7.1.3.2
- **Tailwind CSS**: 2.2.19
- **Devise**: 4.8.0
- **CanCanCan**: 3.3.0

## Setup Guide

Follow these steps to set up the project on your local machine.

### Prerequisites

- Ruby (3.0.6)
- Rails (7.1.3.2)
- PostgreSQL (>= 9.5)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/job-board.git
   cd job-board
    ```
2. **Install the dependencies:**
    ```bash
    bundle install
    ```
3. **Set up the database:**
    ```bash
    rails db:create db:migrate db:seed
    ```
4. **Set up environment variables:**
    ```bash
    cp .env.example .env
    ```
5. **Start the server:**
    ```bash
    rails s
    ```
6. **Visit http://localhost:3000 in your browser.**

7. **Usage:**
    - **Admin:**
      - Sign up as an admin to manage the site.
      - Visit http://localhost:3000/admin/dashboard to access the admin dashboard.
    - **Employer:**
      - Sign up as an employer to post jobs.
      - Visit http://localhost:3000/employer/dashboard to access the employer dashboard.
    - **Freelancer:**
      - Sign up as a freelancer to view and apply for jobs.
      - Visit http://localhost:3000/freelancer/dashboard to access the freelancer dashboard.

**Contributing:**
- Fork and clone the repository.
- Create a new branch: `git checkout -b your-branch-name`
- Make your changes and commit them: `git commit -m 'Your message here'`
- Push to your fork: `git push origin your-branch-name`
- Create a pull request from your branch
- If you find any bugs or have a feature request, please open an issue.
- If you have any questions, feel free to contact me at [alirazaofficial.com](https://alirazaofficial.com)
- Show your support by ⭐ the project.
- Give suggestions to improve this project.
- Thanks for using Job Board!

## License

This project is open source and available under the [MIT License](LICENSE).

---

## Acknowledgments

- [Devise]()
- [CanCanCan]()
- [Tailwind CSS](https://tailwindcss.com)