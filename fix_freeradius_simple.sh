#!/bin/bash

echo "🔧 Fixing FreeRADIUS User-Name mapping..."

# Stop FreeRADIUS
systemctl stop freeradius

# Create the fixed configuration
cat > /etc/freeradius/3.0/sites-enabled/default << 'CONFIG_EOF'
server default {
    listen {
        type = auth
        ipaddr = *
        port = 1812
    }

    listen {
        type = acct
        ipaddr = *
        port = 1813
    }

    authorize {
        if (!User-Name || User-Name == "") {
            update request {
                User-Name := "%{Calling-Station-Id}"
            }
        }
        sql
    }

    authenticate {
        Auth-Type Accept {
            ok
        }
    }

    accounting {
        sql
    }

    session {
        sql
    }

    post-auth {
        sql
    }
}
CONFIG_EOF

# Test configuration
echo "Testing configuration..."
freeradius -Cx -lstdout

if [ $? -eq 0 ]; then
    echo "✅ Configuration OK - Starting FreeRADIUS"
    systemctl start freeradius
    systemctl status freeradius
else
    echo "❌ Configuration failed"
fi
