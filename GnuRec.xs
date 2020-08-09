#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <stdio.h>
#include "ppport.h"

#include <rec.h>

typedef rec_db_t RecDB;

MODULE = DB::GnuRec		PACKAGE = DB::GnuRec

TYPEMAP: <<END
RecDB	T_PTROBJ
END

RecDB
rec_db_new()
    OUTPUT:
        RETVAL

MODULE = DB::GnuRec PACKAGE = RecDB PREFIX = recdb_

void
recdb_DESTROY(db)
        RecDB db
    CODE:
        rec_db_destroy(db);

int
recdb_load_file(this, in, file_name)
    RecDB this;
    FILE *in;
    char *file_name;
INIT:
    rec_parser_t parser;
    rec_rset_t rset;
    parser = rec_parser_new (in, file_name);
CODE:
    fprintf(stderr, "Woops\n");
    if (!parser) {
      RETVAL = 0;
    } else {
      while (rec_parse_rset(parser, &rset)) {
        printf ("%p\n", rset);
        if (!rec_db_insert_rset(this, rset, rec_db_size(this))) {
          RETVAL = 0;
          break;
        }
      }
    }
CLEANUP:
    rec_parser_destroy(parser);

int
recdb_rec_db_size(db)
    RecDB db;
CODE:
    RETVAL = rec_db_size(db);
OUTPUT:
    RETVAL
