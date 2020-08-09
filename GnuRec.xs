#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <stdio.h>
#include "ppport.h"

#include <rec.h>

typedef rec_db_t RecDB;
typedef rec_rset_t RecRset;
typedef rec_rset_elem_t *RecRsetElem;

MODULE = DB::GnuRec		PACKAGE = DB::GnuRec

TYPEMAP: <<END
RecDB	T_PTROBJ
RecRset	T_PTROBJ
RecRsetElem	T_PTROBJ
END

RecDB
rec_db_new()
    OUTPUT:
        RETVAL

MODULE = DB::GnuRec PACKAGE = RecDB

void
DESTROY(db)
        RecDB db
    CODE:
        rec_db_destroy(db);

int
load_file(this, in, file_name)
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
OUTPUT:
    RETVAL
CLEANUP:
    rec_parser_destroy(parser);

int
rec_db_size(db)
    RecDB db;

RecRset
rec_db_get_rset(db, pos)
    RecDB db;
    int pos;
CODE:
    RETVAL = rec_db_get_rset(db, pos);
OUTPUT:
    RETVAL

MODULE = DB::GnuRec PACKAGE = RecRset

int
rec_rset_num_elems(rset)
    RecRset rset;
OUTPUT:
    RETVAL

int
rec_rset_num_records(rset)
    RecRset rset;
OUTPUT:
    RETVAL

int
rec_rset_num_comments(rset)
    RecRset rset;
OUTPUT:
    RETVAL

RecRsetElem
rec_rset_get_elem(this, pos)
    RecRset this;
    int pos;
PREINIT:
    RecRsetElem out;
INIT:
    out = (RecRsetElem)malloc(sizeof(*out));
CODE:
    if (out != NULL)
    {
        *out = rec_rset_get_elem(this, pos);
        RETVAL = out;
    }
    else
    {
        XSRETURN_UNDEF;
    }
OUTPUT:
    RETVAL

RecRsetElem
rec_rset_get_record(this, pos)
    RecRset this;
    int pos;
PREINIT:
    RecRsetElem out;
INIT:
    out = (RecRsetElem)malloc(sizeof(*out));
CODE:
    if (out != NULL)
    {
        *out = rec_rset_get_record(this, pos);
        RETVAL = out;
    }
    else
    {
        XSRETURN_UNDEF;
    }
OUTPUT:
    RETVAL

RecRsetElem
rec_rset_get_comment(this, pos)
    RecRset this;
    int pos;
PREINIT:
    RecRsetElem out;
INIT:
    out = (RecRsetElem)malloc(sizeof(*out));
CODE:
    if (out != NULL)
    {
        *out = rec_rset_get_comment(this, pos);
        RETVAL = out;
    }
    else
    {
        XSRETURN_UNDEF;
    }
OUTPUT:
    RETVAL


RecRsetElem
rec_rset_first(this)
    RecRset this;
PREINIT:
    RecRsetElem out;
INIT:
    out = (RecRsetElem)malloc(sizeof(*out));
CODE:
    if (out != NULL)
    {
        *out = rec_rset_first(this);
        RETVAL = out;
    }
    else
    {
        XSRETURN_UNDEF;
    }
OUTPUT:
    RETVAL

void
rec_rset_next(this, elem)
    RecRset this;
    RecRsetElem elem;
CODE:
    # Ugly as fuck...
    *elem = rec_rset_next(this, *elem);

int
rec_rset_elem_record_p (this, elem)
    RecRset this;
    RecRsetElem elem;
CODE:
    RETVAL = rec_rset_elem_record_p(this, *elem);
OUTPUT:
    RETVAL

int
rec_rset_elem_comment_p (this, elem)
    RecRset this;
    RecRsetElem elem;
CODE:
    RETVAL = rec_rset_elem_comment_p(this, *elem);
OUTPUT:
    RETVAL

MODULE = DB::GnuRec PACKAGE = RecRsetElemPtr

void
DESTROY(e)
        RecRsetElem e
    CODE:
        free(e);

int
rec_rset_elem_p (this)
    RecRsetElem this;
CODE:
    RETVAL = rec_rset_elem_p(*this);
OUTPUT:
    RETVAL

#
# RecRsetElem
# rec_rset_next_record(rset, elem)
#     RecRset rset;
#     RecRsetElem elem;
# OUTPUT:
#     RETVAL
#
# RecRsetElem
# rec_rset_next_comment(rset, elem)
#     RecRset rset;
#     RecRsetElem elem;
# OUTPUT:
#     RETVAL
#
