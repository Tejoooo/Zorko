# ZORKO App

Welcome to the ZORKO App! This app is your one-stop solution to find delicious meals within your budget, empower restaurant owners with a dynamic dashboard for menu customization, and facilitate a vibrant community platform for users to share their dining experiences. It also integrates a map feature for effortless exploration of nearby ZORKO outlets. The app is built using Flutter for the frontend and Django for the backend.

## Features

1. **Budget Setting:**
   - An easy-to-use interface allowing users to set their spending limit for meals conveniently upon opening the app.

2. **Food Options Showcase:**
   - An attractive page showcasing food options tailored to users' budgets, accompanied by engaging visuals and descriptions.

3. **Community Platform:**
   - Users can share photos, like and comment on posts, and rate featured products, interacting with the ZORKO community.

4. **Nearby Outlets:**
   - Access to nearby ZORKO outlets, including dine-in options, offers, coupons, and delivery details, enhancing convenience for users.

5. **Loyalty Rewards Program:**
   - Earn points with purchases and redeem rewards like cash prizes and food vouchers.

6. **Secure Login:**
   - Secure login through number and OTP verification, prioritizing user account safety.

7. **Admin Dashboard:**
   - Easy backend management for administrators for editing the menu via an admin dashboard.

8. **Responsive Design:**
   - Optimized for seamless access across devices, enhancing user experience.

9. **Contact Section:**
   - A contact section with social media handles for users to connect with ZORKO easily.

## Technology Stack

- **Frontend:** Flutter
- **Backend:** Django, Django REST framework

## Getting Started

### Prerequisites

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Python: [Download Python](https://www.python.org/downloads/)
- Django: `pip install django`
- Django REST framework: `pip install djangorestframework`

### Installation

1. **Clone the repository:**
    ```bash
    git clone https://github.com/Tejoooo/Zorko
    cd zorko-companion-app
    ```

2. **Setup Backend:**
    - Navigate to the backend directory:
      ```bash
      cd backend
      ```
    - Create a virtual environment:
      ```bash
      python -m venv venv
      source venv/bin/activate # On Windows use `venv\Scripts\activate`
      ```
    - Install the required packages:
      ```bash
      pip install -r requirements.txt
      ```
    - Apply migrations:
      ```bash
      python manage.py migrate
      ```
    - Start the Django server:
      ```bash
      python manage.py runserver
      ```

3. **Setup Frontend:**
    - Navigate to the frontend directory:
      ```bash
      cd frontend
      ```
    - Get Flutter dependencies:
      ```bash
      flutter pub get
      ```
    - Run the app:
      ```bash
      flutter run
      ```

## Usage

1. **Set Budget:**
   - Upon opening the app, set your spending limit for meals.

2. **Browse Food Options:**
   - Explore food options within your budget with engaging visuals and descriptions.

3. **Interact with Community:**
   - Share photos, like, comment on posts, and rate products within the ZORKO community.

4. **Find Nearby Outlets:**
   - Access information about nearby ZORKO outlets, including dine-in options, offers, coupons, and delivery details.

5. **Earn and Redeem Rewards:**
   - Participate in the loyalty rewards program to earn points and redeem rewards.

6. **Secure Login:**
   - Log in securely using number and OTP verification.

7. **Admin Dashboard:**
   - Admins can manage the menu easily through the admin dashboard.

8. **Responsive Experience:**
   - Enjoy a seamless user experience across all devices.

9. **Contact Us:**
   - Connect with ZORKO through social media handles provided in the contact section.

## Contributing

We welcome contributions! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature-name`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add some feature'`).
5. Push to the branch (`git push origin feature/your-feature-name`).
6. Open a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Thanks to the Flutter and Django communities for their amazing tools and libraries.
- Special thanks to all the contributors who have helped improve this project.

---

Feel free to reach out if you have any questions or need further assistance!

Happy Coding!
