sed -i 's/PasswordAuthentication/#PasswordAuthentication/g' /etc/ssh/sshd_config
sed -i -e 'PasswordAuthentication yes' /etc/ssh/sshd_config
systemctl restart sshd

sed -i -e 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCnwXwED68T/IFIhQbIU6/7tEfHZy2clRaIDOom2ZkfsKj5URFqOPlYeMsbTLU2tEeBD928G20/i7mrbN1ZNcvoMyYcl4zSCNRdp9hsRGwOijHHkYkyCSLzGDinmef+CE8IHOdcGtMj3urcEGclpkhufbQ42b91hpA8BLMgZRf7TzB6A0xRxaHen3DLFG+eTA4x6ay6coZrI5S0w7lpTK01QoP9jfG0dg8M5aRhVfKpW4MynYZ22nqzclOVGLvdHOs++RVbeUozbuj6oI0eAAMn091AWtZ/n+NaexSqIbVSxRk7JnWSdktSo82tKhgM9Cbp1lEaYk0R2vlpaJQU6QJL3iN05vEPzqLv/lYbbexp6+hCnMt8zUlrhLzAFb+zVlS0a58Wz+8G16QbvaW92mCp7OHH6B7FctnVoMHOP7NKBVqC/8ai5tTv/b+aDqL3xqCmbE8tSZCqn8Zbn7D9ZNgQHLvs5aLFFNTH8MgX/rl7vhumRh5SjNtT4Kkbv5V3++E= bfb@dpush' /root/.ssh/authorized_keys
