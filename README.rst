
==================================
Fluentd-plugin Formula
==================================

Service fluentd-plugin description


Sample Metadata
===============

Single fluentd-plugin service

.. code-block:: yaml

    applications:
    - service.fluentd_plugin
    parameters:
      fluentd_plugin:
        client:
          enabled: true
          elasticsearch:
            host: 10.11.0.54
            port: 855
          rabbitmq:
            user: admin
            password: admin
            vhost: /
            cluster_node01_hostname: msg01
            cluster_node02_hostname: msg02
            cluster_node03_hostname: msg03
            cluster_node01_address: 10.11.0.41
            cluster_node02_address: 10.11.0.42
            cluster_node03_address: 10.11.0.43


References
==========

* A link to the documentation
* A link to the home page
* A link to the source code


Documentation and Bugs
======================

To learn how to install and update salt-formulas, consult the documentation
available online at:

    http://salt-formulas.readthedocs.io/

In the unfortunate event that bugs are discovered, they should be reported to
the appropriate issue tracker. Use GitHub issue tracker for specific salt
formula:

    https://github.com/salt-formulas/salt-formula-fluentd-plugin/issues

For feature requests, bug reports or blueprints affecting entire ecosystem,
use Launchpad salt-formulas project:

    https://launchpad.net/salt-formulas

Developers wishing to work on the salt-formulas projects should always base
their work on master branch and submit pull request against specific formula.

You should also subscribe to mailing list (salt-formulas@freelists.org):

    https://www.freelists.org/list/salt-formulas

Any questions or feedback is always welcome so feel free to join our IRC
channel:

    #salt-formulas @ irc.freenode.net
