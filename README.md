# MAG-CUPS: 5G CUPS Simulation using Open5GS, UERANSIM, BNGBlaster, and ContainerLab

**MAG-CUPS** is an open-source project designed to simulate a **5G CUPS (Centralized User Plane Separation)** network architecture. This project leverages **ContainerLab** for container-based network simulation, **Open5GS** for the 5G core network, **UERANSIM** for 5G RAN simulation, and **BNGBlaster** for simulating broadband access using **PPPoE** and **IPoE**.

## Overview

This project is built to simulate a 5G mobile network with a **CUPS architecture**, where the **Control Plane** and **User Plane** are separated. The solution uses **Open5GS** for the 5G core network, **UERANSIM** for simulating the **gNB** (5G base station) and **UE** (User Equipment), and **BNGBlaster** for simulating broadband access using **PPPoE** and **IPoE** protocols.

The entire network is simulated in a containerized environment using **ContainerLab**, providing a flexible and scalable platform for deployment, testing, and experimentation with 5G CUPS networks.

## Features

- **5G CUPS Simulation**: Simulates 5G with separated Control Plane and User Plane architecture.
- **Containerized Setup**: Utilizes **ContainerLab** for orchestrating and managing the container-based network simulation.
- **Open5GS**: Implements the 5G core network including AMF,NRF,UDM,AUSF, and other components.
- **UERANSIM**: Simulates the **gNB** and **UE** for 5G RAN (Radio Access Network).
- **PPPoE/IPoE Simulation**: Simulates broadband access with **BNGBlaster** for managing PPPoE and IPoE sessions.
- **Flexible Setup**: Customizable network topologies and components to suit various testing scenarios.
- **Open Source**: Fully open-source solution suitable for research, education, and testing purposes.

## Components

### 1. **ContainerLab**
   - **ContainerLab** is used to deploy network components in isolated containers.
   - It simplifies the process of deploying complex networks and simulating real-world network conditions.
   - The key network components (**Open5GS**, **UERANSIM**, and **BNGBlaster**) are containerized.

### 2. **Open5GS**
   - **Open5GS** provides the **5G core network** including essential components like **AMF** (Access and Mobility Management Function), **SMF** (Session Management Function), **UPF** (User Plane Function), and **AUSF** (Authentication Server Function).
   - Open5GS is configured for a **CUPS** architecture, where the **Control Plane** (AMF, SMF, etc.) is separated from the **User Plane** (UPF).
   
### 3. **UERANSIM**
   - **UERANSIM** is used to simulate the **gNB** (5G base station) and **UE** (User Equipment), providing the RAN (Radio Access Network) simulation.
   - It supports key 5G RAN features, including 5G NR (New Radio) and the connection setup between the gNB and UE.

### 4. **BNGBlaster**
   - **BNGBlaster** simulates Broadband Network Gateway (BNG) behavior and manages broadband sessions.
   - It provides **PPPoE** and **IPoE** session management, simulating end-user access scenarios including IP address allocation, session management, and bandwidth management.

### 5. **PPPoE/IPoE Session Management**
   - This simulation provides **PPPoE** and **IPoE** session management capabilities, simulating broadband access using BNGBlaster to create fixed sessions for end users.

## Installation

### Prerequisites

Before you begin, ensure that the following are installed on your machine:

- **Docker**: Required for running the containerized components.
- **ContainerLab**: To create and manage container-based network simulations.
- **Git**: For cloning the repository.
- **Python** (optional): Some scripts may require Python.

### Steps

1. **Clone the Repository**:

   First, clone this repository to your local machine:
   ```bash
   git clone https://github.com/htakkey/mag-cups.git
   cd mag-cups
   
   
2.   **Deploy the ContainerLab Environment**:

     Deploy the containerized network environment using the ContainerLab configuration:
     ```bash
     clab dep -t mag-cups.clab.yml
3.   **Register the 5G Subscriber**:
     Navigate to the scripts directory and register the 5G subscriber:
     ```bash
     ./register_subscriber.sh
4.   **Start the Open5GS Core Network (AMF,NRF...)**:
     ```bash
     cd scripts
     ./start_open5gs.sh

5.   **Start PPPoE/IPoE Session using BNGBlaster**:
     Start the broadband session using BNGBlaster to simulate PPPoE or IPoE session management:
     ```bash
     ./start_dhcp_red.sh
     ./start_pppoe.sh   # To start session with traffic
6.   **Start the 5G Session**:
     Finally, start the 5G session (just 1 IMSI or 10 IMSIs)
     ```bash
     cd scripts
     ./start_5g_cups_10IMSI.sh
     ./start_5g_cups.sh
