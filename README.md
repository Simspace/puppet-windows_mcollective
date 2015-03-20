# windows_mcollective

#### Table of Contents

1. [Overview](#overview)
2. [Setup requirements](#setup-requirements)
3. [Usage - Configuration options and additional functionality](#usage)

## Overview

This module will install mcollective on a windows host re-using the ruby installion
from the puppet community edition installation. It incldues the puppet plugin as well
as the shell plugin.

## Setup Requirements

This module uses ruby from the puppet community edition installation.
This module requires a modified staging module to suppoert zip files under windows
with 7za.

## Usage

Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.

**Class:** windows_mcollective

**Variables**

*server*: The ActiveMQ server. Defaults to 10.10.254.1

**Example**

```ruby
class { windows_mcollective:
  server => '10.10.254.1',
}
```
