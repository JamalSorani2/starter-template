# DESIGN.md - Malaeb (Stadium Booking App)

## 1. Project Overview
**App Name:** Malaeb (ملاعب)
**Purpose:** A sports venue booking application that allows users to discover, check availability, and book football pitches/stadiums easily.
**Atmosphere:** Energetic, trustworthy, modern, and action-oriented. The UI should feel clean and fast, getting the user from "discovery" to "booked" with minimal friction.

## 2. Color Palette & Semantic Roles
The color scheme is inspired by sports (turf, night games) and uses traffic-light colors for availability.

* **Primary Brand:** `#10B981` (Turf Green) - Used for primary actions, active states, and brand logos.
* **Background (Light Mode):** `#F3F4F6` (Cool Gray) - App background to make white stadium cards pop.
* **Surface:** `#FFFFFF` (White) - Used for cards, modals, and bottom navigation.
* **Text (Primary):** `#111827` (Very Dark Gray) - Used for headings and primary body text.
* **Text (Secondary):** `#6B7280` (Medium Gray) - Used for labels, placeholder text, and minor details.
* **State: Available:** `#10B981` (Green) - Used for open time slots.
* **State: Booked/Unavailable:** `#EF4444` (Red) - Used for taken time slots or errors.
* **State: Selected:** `#3B82F6` (Blue) - Used when the user is actively selecting a time slot before confirming.

## 3. Typography
* **Primary Font:** `Inter`, `Roboto`, or system default sans-serif.
* **Headings (H1):** 24px, Bold. (Used for Screen Titles, e.g., "All Stadiums")
* **Headings (H2):** 18px, Semi-Bold. (Used for Stadium Names, Section Headers)
* **Body Regular:** 14px, Regular. (Used for descriptions, standard text)
* **Labels/Small:** 12px, Medium. (Used for input labels, time slot text)

## 4. Layout & Spacing
* **Grid System:** 8px base unit.
* **Screen Padding:** 16px on the left and right of mobile screens.
* **Border Radius:** * `12px` for Stadium Cards and Modals (friendly, modern).
    * `8px` for Buttons, Input fields, and Time slot chips.
    * `50%` (Circle) for User Avatars and Icon Buttons.

## 5. UI Components & Rules

### Buttons
* **Primary Button:** Background: Primary Green (`#10B981`), Text: White, Bold. 100% width on mobile. Hover/Active: Darker Green (`#059669`).
* **Secondary/Outline Button:** Background: Transparent, Border: 1px solid Primary Green, Text: Primary Green.
* **Disabled Button:** Background: `#D1D5DB`, Text: `#9CA3AF`. Non-clickable.

### Inputs & Forms
* All text inputs must have a visible label (12px, Secondary Text).
* Input container: 1px solid `#D1D5DB`, `8px` border-radius, `16px` internal padding.
* On Focus: Border changes to Primary Green (`#10B981`).

### Cards (Stadium Listing)
* **Structure:** Top half is the stadium image. Bottom half contains Stadium Name, Location, Price per hour, and Rating.
* **Interaction:** Tapping the entire card navigates to the Stadium Details screen.
* **Shadow:** Subtle drop shadow (`box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1)`).

---

## 6. Required Screens & User Flows

### A. Authentication Flow
* **Sign Up Screen:**
    * Inputs: Full Name, Email/Phone, Password, Confirm Password.
    * Action: "Create Account" (Primary Button).
* **Sign In Screen:**
    * Inputs: Email/Phone, Password.
    * Action: "Login" (Primary Button).
    * Link: "Forgot Password?" below the login button.
* **Reset Password Screen:**
    * Input: Email/Phone to receive OTP/Link.
    * Action: "Send Reset Link".
* **Profile/Settings (Logout):**
    * Simple screen showing user details with a prominent red "Logout" button at the bottom.

### B. Core App Flow
* **1. Discover / See All Stadiums (Home Screen)**
    * Header: "Hello, [User Name]" with a search bar.
    * Content: A vertically scrolling list of **Stadium Cards**.
    * Filters: "Nearest", "Highest Rated", "Price".

* **2. Stadium Details**
    * Hero Image: Large image of the pitch at the top.
    * Header: Stadium Name, Location (with map pin icon), and Price.
    * Description: Size of pitch (e.g., 5v5, 7v7, 11v11), grass type (Artificial/Natural).
    * Amenities: Icons for Showers, Parking, Balls Provided, Water.
    * Action: Fixed bottom bar with a "Check Availability" primary button.

* **3. Availability & Booking (Appoint Stadium)**
    * **Date Selector:** Horizontal scrolling list of dates (Today, Tomorrow, etc.).
    * **Time Slots (Grid):** * Display slots in a grid (e.g., 18:00, 19:00, 20:00).
        * Color Code: Green (Available), Red with strike-through (Booked).
    * **Interaction:** User taps an available green slot. It turns Blue (Selected).
    * **Confirmation:** Fixed bottom bar showing Total Price and a "Confirm Booking" button.

## 7. Accessibility & UX Guardrails
* **Loading States:** Use skeleton loaders for stadium cards while fetching data from the database.
* **Empty States:** If no stadiums match a search, show an illustration with text "No stadiums found" and a button to "Clear Search".
* **Feedback:** Always show a success toast/modal ("Booking Confirmed!") after a successful appointment, and error messages ("Invalid Password") clearly in red below input fields.