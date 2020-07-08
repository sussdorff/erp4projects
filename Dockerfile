FROM sussdorff/project-open:oacs-5-10

WORKDIR /var/www/openacs/packages

# Packages to overwrite
ENV PKGS_LIST "cognovis-core intranet-invoices intranet-openoffice intranet-material"

RUN for pkg in ${PKGS_LIST} ; do echo $pkg \
    && rm -rf $pkg && wget -q https://gitlab.com/cognovis-5/$pkg/-/archive/master/$pkg.tar.gz \
    && tar xfz $pkg.tar.gz && mv ${pkg}-master-* $pkg && rm $pkg.tar.gz ; done

ENV PKGS_OLD_LIST "webix-portal intranet-collmex intranet-fs"

RUN for pkg in ${PKGS_OLD_LIST} ; do echo $pkg \
    && rm -rf $pkg && wget -q https://gitlab.com/cognovis/$pkg/-/archive/master/$pkg.tar.gz \
    && tar xfz $pkg.tar.gz && mv ${pkg}-master-* $pkg && rm $pkg.tar.gz ; done

ENV DEPRECATE_LIST "views monitoring intranet-jquery intranet-chilkat intranet-mail"

RUN for pkg in ${DEPRECATE_LIST} ; do echo $pkg \
    && rm -rf $pkg && wget -q https://gitlab.com/cognovis/$pkg/-/archive/master/$pkg.tar.gz \
    && tar xfz $pkg.tar.gz && mv ${pkg}-master-* $pkg && rm $pkg.tar.gz ; done

COPY config.tcl.postload /var/www/openacs/tcl/config.tcl.postload
