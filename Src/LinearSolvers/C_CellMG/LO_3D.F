#undef  BL_LANG_CC
#ifndef BL_LANG_FORT
#define BL_LANG_FORT
#endif

#include <REAL.H>
#include <CONSTANTS.H>
#include "LO_BCTYPES.H"
#include "LO_F.H"
#include "ArrayLim.H"

c-----------------------------------------------------------------------
      subroutine FORT_RESIDL (
     $     res, DIMS(res), 
     $     rhs, DIMS(rhs),
     $     phi, DIMS(phi),
     $     lo, hi, nc
     $     )
      implicit none
      integer nc
      integer lo(BL_SPACEDIM)
      integer hi(BL_SPACEDIM)
      integer DIMDEC(phi)
      REAL_T phi(DIMV(phi),nc)
      integer DIMDEC(rhs)
      REAL_T rhs(DIMV(rhs),nc)
      integer DIMDEC(res)
      REAL_T res(DIMV(res),nc)

      integer i,j,k,n

      do n = 1, nc
         do k = lo(3), hi(3)
            do j = lo(2), hi(2)
               do i = lo(1), hi(1)
                  res(i,j,k,n) = rhs(i,j,k,n) - phi(i,j,k,n)
               end do
            end do
         end do
      end do
      end
c-----------------------------------------------------------------------
      subroutine FORT_HARMONIC_AVERAGEEC (
     $     c, DIMS(c),
     $     f, DIMS(f),
     $     lo, hi, nc,
     $     cdir
     $     )

      implicit none
      integer nc
      integer lo(BL_SPACEDIM)
      integer hi(BL_SPACEDIM)
      integer cdir
      integer DIMDEC(f)
      REAL_T f(DIMV(f),nc)
      integer DIMDEC(c)
      REAL_T c(DIMV(c),nc)

      integer n, i, j, k

      select case(cdir)

      case (0)
         do n = 1, nc
            do k = lo(3), hi(3)
               do j = lo(2), hi(2)
                  do i = lo(1), hi(1)

                     c(i,j,k,n) = four/(
     $                    + 1.0D0/f(2*i,2*j  ,2*k  ,n)
     $                    + 1.0D0/f(2*i,2*j+1,2*k  ,n)
     $                    + 1.0D0/f(2*i,2*j  ,2*k+1,n)
     $                    + 1.0D0/f(2*i,2*j+1,2*k+1,n) )

                  end do
               end do
            end do
         end do

      case (1)
         do n = 1, nc
            do k = lo(3), hi(3)
               do j = lo(2), hi(2)
                  do i = lo(1), hi(1)

                     c(i,j,k,n) = four/(
     $                    + 1.0D0/f(2*i  ,2*j,2*k  ,n)
     $                    + 1.0D0/f(2*i+1,2*j,2*k  ,n)
     $                    + 1.0D0/f(2*i  ,2*j,2*k+1,n)
     $                    + 1.0D0/f(2*i+1,2*j,2*k+1,n) )

                  end do
               end do
            end do
         end do
      case (2)
         do n = 1, nc
            do k = lo(3), hi(3)
               do j = lo(2), hi(2)
                  do i = lo(1), hi(1)

                     c(i,j,k,n) = four/(
     $                    + 1.0D0/f(2*i  ,2*j  ,2*k,n)
     $                    + 1.0D0/f(2*i+1,2*j  ,2*k,n)
     $                    + 1.0D0/f(2*i  ,2*j+1,2*k,n)
     $                    + 1.0D0/f(2*i+1,2*j+1,2*k,n) )

                  end do
               end do
            end do
         end do

      end select

      end
c-----------------------------------------------------------------------
      subroutine FORT_AVERAGEEC (
     $     c, DIMS(c),
     $     f, DIMS(f),
     $     lo, hi, nc,
     $     cdir
     $     )

      implicit none
      integer nc
      integer lo(BL_SPACEDIM)
      integer hi(BL_SPACEDIM)
      integer cdir
      integer DIMDEC(f)
      REAL_T f(DIMV(f),nc)
      integer DIMDEC(c)
      REAL_T c(DIMV(c),nc)

      integer n, i, j, k

      select case(cdir)

      case (0)
         do n = 1, nc
            do k = lo(3), hi(3)
               do j = lo(2), hi(2)
                  do i = lo(1), hi(1)

                     c(i,j,k,n) = fourth*(
     $                    + f(2*i,2*j  ,2*k  ,n)
     $                    + f(2*i,2*j+1,2*k  ,n)
     $                    + f(2*i,2*j  ,2*k+1,n)
     $                    + f(2*i,2*j+1,2*k+1,n) )

                  end do
               end do
            end do
         end do

      case (1)
         do n = 1, nc
            do k = lo(3), hi(3)
               do j = lo(2), hi(2)
                  do i = lo(1), hi(1)

                     c(i,j,k,n) = fourth*(
     $                    + f(2*i  ,2*j,2*k  ,n)
     $                    + f(2*i+1,2*j,2*k  ,n)
     $                    + f(2*i  ,2*j,2*k+1,n)
     $                    + f(2*i+1,2*j,2*k+1,n) )

                  end do
               end do
            end do
         end do

      case (2)
         do n = 1, nc
            do k = lo(3), hi(3)
               do j = lo(2), hi(2)
                  do i = lo(1), hi(1)

                     c(i,j,k,n) = fourth*(
     $                    + f(2*i  ,2*j  ,2*k,n)
     $                    + f(2*i+1,2*j  ,2*k,n)
     $                    + f(2*i  ,2*j+1,2*k,n)
     $                    + f(2*i+1,2*j+1,2*k,n) )

                  end do
               end do
            end do
         end do

      end select

      end
c-----------------------------------------------------------------------
      subroutine FORT_AVERAGECC (
     $     c, DIMS(c),
     $     f, DIMS(f),
     $     lo, hi, nc
     $     )

      implicit none
      integer nc
      integer DIMDEC(f)
      integer DIMDEC(c)
      integer lo(BL_SPACEDIM)
      integer hi(BL_SPACEDIM)
      REAL_T f(DIMV(f),nc)
      REAL_T c(DIMV(c),nc)

      integer i, j, k, n

      do n = 1, nc
         do k = lo(3), hi(3)
            do j = lo(2), hi(2)
               do i = lo(1), hi(1)

                  c(i,j,k,n) =  eighth*(
     $                 + f(2*i+1,2*j+1,2*k  ,n)
     $                 + f(2*i  ,2*j+1,2*k  ,n)
     $                 + f(2*i+1,2*j  ,2*k  ,n)
     $                 + f(2*i  ,2*j  ,2*k  ,n)
     $                 + f(2*i+1,2*j+1,2*k+1,n)
     $                 + f(2*i  ,2*j+1,2*k+1,n)
     $                 + f(2*i+1,2*j  ,2*k+1,n)
     $                 + f(2*i  ,2*j  ,2*k+1,n) )

               end do
            end do
         end do
      end do

      end
c-----------------------------------------------------------------------
c
c Don't thread this.  We instead thread LinOp::applyBC() across faces.
c
      subroutine FORT_APPLYBC (
     $     flagden, flagbc, maxorder,
     $     phi, DIMS(phi),
     $     cdir, bct, bcl,
     $     bcval, DIMS(bcval),
     $     mask, DIMS(mask),
     $     den, DIMS(den),
     $     lo, hi, nc,
     $     h
     $     )

      implicit none
c
c     If the boundary is of Neumann type, set the ghost cell value to
c     that of the outermost point in the valid data (2nd order accurate)
c     and then fill the "den" array with the value "1"
c     
c     
c     If flagbc==1:
c     
c     If the boundary is of Dirichlet type, construct a polynomial
c     interpolation through the boundary location and internal points
c     (at locations x(-1:len-2) that generates the ghost cell value (at
c     location xInt).  Then fill the ghost cell with the interpolated value.
c     If flagden==1, load the "den" array with the interpolation
c     coefficient corresponding to outermost point in the valid region
c     ( the coef(0) corresponding to the location x(0) )
c
c     Note: 
c     The bc type = LO_REFLECT_ODD is a special type of dirichlet condition,
c     in that we want a "zeroth" order interpolant to fill the ghost cell.
c     If this were treated in the normal way, then ALL boundaries would be
c     low order.
c      
      integer maxorder
      integer nc, cdir, flagden, flagbc
      integer lo(BL_SPACEDIM)
      integer hi(BL_SPACEDIM)
      integer DIMDEC(phi)
      REAL_T phi(DIMV(phi),nc)
      integer DIMDEC(den)
      REAL_T den(DIMV(den))
      integer DIMDEC(bcval)
      REAL_T bcval(DIMV(bcval),nc)
      integer DIMDEC(mask)
      integer mask(DIMV(mask))
      integer bct
      REAL_T bcl
      REAL_T h(BL_SPACEDIM)

      integer i, j, k, n
      logical is_dirichlet, is_neumann

      integer lenx, leny, lenz, m

      integer Lmaxorder
      integer maxmaxorder
      parameter(maxmaxorder=4)
      REAL_T x(-1:maxmaxorder-2)
      REAL_T coef(-1:maxmaxorder-2)
      REAL_T xInt
      parameter(xInt = -0.5D0)

      is_dirichlet(i) = ( i .eq. LO_DIRICHLET )
      is_neumann(i) = (i .eq. LO_NEUMANN)

      if ( maxorder .eq. -1 ) then
         Lmaxorder = maxmaxorder
      else
         Lmaxorder = MIN(maxorder,maxmaxorder)
      end if
      lenx = MIN(hi(1)-lo(1), Lmaxorder-2)
      leny = MIN(hi(2)-lo(2), Lmaxorder-2)
      lenz = MIN(hi(3)-lo(3), Lmaxorder-2)

      do m=0,maxmaxorder-2
         x(m) = m + 0.5D0
      end do
c
c     TODO:
c     In order for this to work with growing multigrid, must
c     sort xa[] because it is possible for the xb value to lay
c     within this range.
c
      select case (cdir)

      case (0)
         !     
         ! The Left face of the grid
         !
         if (is_neumann(bct)) then
            do n = 1, nc
               do k = lo(3), hi(3)
                  do j = lo(2), hi(2)
                     phi(lo(1)-1,j,k,n) = merge(
     $                    phi(lo(1),j,k,n),
     $                    phi(lo(1)-1,j,k,n),
     $                    mask(lo(1)-1,j,k) .gt. 0)
                  end do
               end do
            end do
            if ( flagden .eq. 1) then
               do k = lo(3), hi(3)
                  do j = lo(2), hi(2)
                     den(lo(1),j,k) = 1.0D0
                  end do
               end do
            end if
         else if (is_dirichlet(bct)) then
            x(-1) = - bcl/h(1)
            call polyInterpCoeff(xInt, x, lenx+2, coef)
            do n = 1, nc
               if ( flagbc .eq. 1 ) then
                  do k = lo(3), hi(3)
                     do j = lo(2), hi(2)
                        phi(lo(1)-1, j, k, n) = merge(
     $                       bcval(lo(1)-1,j,k,n)*coef(-1),
     $                       phi(lo(1)-1, j,k, n),
     $                       mask(lo(1)-1,j,k) .gt. 0)
                     end do
                  end do
               else
                  do k = lo(3), hi(3)
                     do j = lo(2), hi(2)
                        phi(lo(1)-1, j, k, n) = merge(
     $                       0.0D0,
     $                       phi(lo(1)-1, j, k, n),
     $                       mask(lo(1)-1,j, k) .gt. 0)
                     end do
                  end do
               end if
               do m = 0, lenx
                  do k = lo(3), hi(3)
                     do j = lo(2), hi(2)
                        phi(lo(1)-1,j,k,n) = merge(
     $                       phi(lo(1)-1,j,k,n)
     $                       + phi(lo(1)+m, j, k, n)*coef(m),
     $                       phi(lo(1)-1,j,k,n),
     $                       mask(lo(1)-1,j,k) .gt. 0)
                     end do
                  end do
               end do
            end do
            if ( flagden .eq. 1 ) then
               do k = lo(3), hi(3)
                  do j = lo(2), hi(2)
                     den(lo(1),j,k) = merge(coef(0), 0.0D0,
     $                    mask(lo(1)-1,j,k) .gt. 0)
                  end do
               end do
            end if
         else if ( bct .eq. LO_REFLECT_ODD ) then
            do n = 1, nc
               do k = lo(3), hi(3)
                  do j = lo(2), hi(2)
                     phi(lo(1)-1, j, k, n) = merge(
     $                   -phi(lo(1),j,k,n),
     $                    phi(lo(1)-1,j,k,n),
     $                    mask(lo(1)-1,j,k) .gt. 0)
                  end do
               end do
            end do
            if ( flagden .eq. 1 ) then
               do k = lo(3), hi(3)
                  do j = lo(2), hi(2)
                     den(lo(1),j,k) = merge(-1.0D0, 0.0D0,
     $                    mask(lo(1)-1,j,k) .gt. 0)
                  end do
               end do
            end if
         else
            print *,'UNKNOWN BC ON LEFT FACE IN APPLYBC'
            call bl_error("stop")
         end if

      case (3)
         !
         ! The Right face of the grid
         ! 
         if(is_neumann(bct)) then
            do n = 1, nc
               do k = lo(3), hi(3)
                  do j = lo(2), hi(2)
                     phi(hi(1)+1,j,k,n) = merge(
     $                    phi(hi(1), j, k, n),
     $                    phi(hi(1)+1, j, k, n),
     $                    mask(hi(1)+1,j,k) .gt. 0)
                  end do
               end do
            end do
	    if ( flagden .eq. 1 ) then
               do k = lo(3), hi(3)
                  do j = lo(2), hi(2)
                     den(hi(1),j,k) = 1.0D0
                  end do
               end do
	    end if
         else if (is_dirichlet(bct)) then
            x(-1) = - bcl/h(1)
            call polyInterpCoeff(xInt, x, lenx+2, coef)
            do n = 1, nc
               if ( flagbc .eq. 1 ) then
                  do k = lo(3), hi(3)
                     do j = lo(2), hi(2)
                        phi(hi(1)+1,j,k,n) = merge(
     $                       bcval(hi(1)+1,j,k,n)*coef(-1),
     $                       phi(hi(1)+1,j,k,n),
     $                       mask(hi(1)+1,j,k) .gt. 0)
                     end do
                  end do
               else
                  do k = lo(3), hi(3)
                     do j = lo(2), hi(2)
                        phi(hi(1)+1,j,k,n) = merge(
     $                       0.0D0,
     $                       phi(hi(1)+1,j,k,n),
     $                       mask(hi(1)+1,j,k) .gt. 0)
                     end do
                  end do
               end if
               do m = 0, lenx
                  do k = lo(3), hi(3)
                     do j = lo(2), hi(2)
                        phi(hi(1)+1,j,k,n) = merge(
     $                       phi(hi(1)+1,j,k,n)
     $                       + phi(hi(1)-m,j,k,n)*coef(m),
     $                       phi(hi(1)+1,j,k,n),
     $                       mask(hi(1)+1,j,k) .gt. 0)
                     end do
                  end do
               end do
            end do
            if ( flagden .eq. 1 ) then
               do k = lo(3), hi(3)
                  do j = lo(2), hi(2)
                     den(hi(1),j,k)   = merge(coef(0), 0.0D0,
     $                    mask(hi(1)+1,j,k) .gt. 0)
                  end do
               end do
            end if
         else if ( bct .eq. LO_REFLECT_ODD ) then
            do n = 1, nc
               do k = lo(3), hi(3)
                  do j = lo(2), hi(2)
                     phi(hi(1)+1, j, k, n) = merge(
     $                   -phi(hi(1),j,k,n),
     $                    phi(hi(1)+1,j,k,n),
     $                    mask(hi(1)+1,j,k) .gt. 0)
                  end do
               end do
            end do
            if ( flagden .eq. 1 ) then
               do k = lo(3), hi(3)
                  do j = lo(2), hi(2)
                     den(hi(1),j,k) = merge(-1.0D0, 0.0D0,
     $                    mask(hi(1)+1,j,k) .gt. 0)
                  end do
               end do
            end if
         else
            print *,'UNKNOWN BC ON RIGHT FACE IN APPLYBC'
            call bl_error("stop")
         end if

         case (1)
            !
            ! The Bottom of the Grid
            !
            if(is_neumann(bct)) then
               do n = 1, nc
                  do k = lo(3), hi(3)
                     do i = lo(1),hi(1)
                        phi(i,lo(2)-1,k,n) = merge(
     $                       phi(i,lo(2),k,n),
     $                       phi(i,lo(2)-1,k,n),
     $                       mask(i,lo(2)-1,k) .gt. 0)
                     end do
                  end do
               end do
               if ( flagden .eq. 1 ) then
                  do k = lo(3), hi(3)
                     do i = lo(1),hi(1)
                        den(i,lo(2),k)   = 1.0D0
                     end do
                  end do
               end if
            else if (is_dirichlet(bct)) then
               x(-1) = - bcl/h(2)
               call polyInterpCoeff(xInt, x, leny+2, coef)
               do n = 1, nc
                  if ( flagbc .eq. 1 ) then
                     do k = lo(3), hi(3)
                        do i = lo(1), hi(1)
                           phi(i,lo(2)-1,k,n) = merge(
     $                          bcval(i,lo(2)-1,k,n)*coef(-1),
     $                          phi(i,lo(2)-1,k,n),
     $                          mask(i,lo(2)-1,k) .gt. 0)
                        end do
                     end do
                  else
                     do k = lo(3), hi(3)
                        do i = lo(1), hi(1)
                           phi(i,lo(2)-1,k,n) = merge(
     $                          0.0D0,
     $                          phi(i,lo(2)-1,k,n),
     $                          mask(i,lo(2)-1,k) .gt. 0)
                        end do
                     end do
                  end if
                  do m = 0, leny
                     do k = lo(3), hi(3)
                        do i = lo(1), hi(1)
                           phi(i, lo(2)-1, k, n) = merge(
     $                          phi(i, lo(2)-1,k,n)
     $                          + phi(i, lo(2)+m, k,n)*coef(m),
     $                          phi(i, lo(2)-1, k, n),
     $                          mask(i, lo(2)-1, k) .gt. 0)
                        end do
                     end do
                  end do
               end do
               if ( flagden .eq. 1 ) then
                  do k = lo(3), hi(3)
                     do i = lo(1), hi(1)
                        den(i, lo(2),k)   = merge(coef(0), 0.0D0,
     $                       mask(i, lo(2)-1,k) .gt. 0)
                     end do
                  end do
               end if
            else if ( bct .eq. LO_REFLECT_ODD ) then
               do n = 1, nc
                  do k = lo(3), hi(3)
                     do i = lo(1), hi(1)
                        phi(i, lo(2)-1, k, n) = merge(
     $                       -phi(i,lo(2),k,n),
     $                       phi(i,lo(2)-1,k,n),
     $                       mask(i,lo(2)-1,k) .gt. 0)
                     end do
                  end do
               end do
               if ( flagden .eq. 1 ) then
                  do k = lo(3), hi(3)
                     do i = lo(1), hi(1)
                        den(i,lo(2),k) = merge(-1.0D0, 0.0D0,
     $                       mask(i,lo(2)-1,k) .gt. 0)
                     end do
                  end do
               end if
            else
               print *,'UNKNOWN BC ON BOTTOM FACE IN APPLYBC'
               call bl_error("stop")
            end if

         case (4)
            !
            ! The top of the grid
            !
            if(is_neumann(bct)) then
               do n = 1, nc
                  do k = lo(3), hi(3)
                     do i = lo(1), hi(1)
                        phi(i,hi(2)+1,k,n) = merge(
     $                       phi(i,hi(2),k,n),
     $                       phi(i,hi(2)+1,k,n),
     $                       mask(i,hi(2)+1,k) .gt. 0)
                     end do
                  end do
               end do
               if ( flagden .eq. 1 ) then
                  do k = lo(3), hi(3)
                     do i = lo(1), hi(1)
                        den(i,hi(2),k)   = 1.0D0
                     end do
                  end do
               end if
            else if (is_dirichlet(bct)) then
               x(-1) = - bcl/h(2)
               call polyInterpCoeff(xInt, x, leny+2, coef)
               do n = 1, nc
                  if ( flagbc .eq. 1 ) then
                     do k = lo(3), hi(3)
                        do i = lo(1), hi(1)
                           phi(i,hi(2)+1,k,n) = merge(
     $                          bcval(i,hi(2)+1,k,n)*coef(-1),
     $                          phi(i,hi(2)+1,k,n),
     $                          mask(i,hi(2)+1,k) .gt. 0)
                        end do
                     end do
                  else
                     do k = lo(3), hi(3)
                        do i = lo(1), hi(1)
                           phi(i,hi(2)+1,k,n) = merge(
     $                          0.0D0,
     $                          phi(i,hi(2)+1,k,n),
     $                          mask(i,hi(2)+1,k) .gt. 0)
                        end do
                     end do
                  end if
                  do m = 0, leny
                     do k = lo(3), hi(3)
                        do i = lo(1), hi(1)
                           phi(i, hi(2)+1,k,n) = merge(
     $                          phi(i,hi(2)+1,k,n)
     $                          + phi(i, hi(2)-m,k,n)*coef(m),
     $                          phi(i,hi(2)+1,k,n),
     $                          mask(i,hi(2)+1,k) .gt. 0)
                        end do
                     end do
                  end do
               end do
               if ( flagden .eq. 1 ) then
                  do k = lo(3), hi(3)
                     do i = lo(1), hi(1)
                        den(i,hi(2),k)   = merge(coef(0), 0.0D0,
     $                       mask(i,hi(2)+1,k) .gt. 0)
                     end do
                  end do
               end if
            else if ( bct .eq. LO_REFLECT_ODD ) then
               do n = 1, nc
                  do k = lo(3), hi(3)
                     do i = lo(1), hi(1)
                        phi(i, hi(2)+1, k, n) = merge(
     $                       -phi(i,hi(2),k,n),
     $                       phi(i,hi(2)+1,k,n),
     $                       mask(i,hi(2)+1,k) .gt. 0)
                     end do
                  end do
               end do
               if ( flagden .eq. 1 ) then
                  do k = lo(3), hi(3)
                     do i = lo(1), hi(1)
                        den(i,hi(2),k) = merge(-1.0D0, 0.0D0,
     $                       mask(i,hi(2)+1,k) .gt. 0)
                     end do
                  end do
               end if
            else
               print *,'UNKNOWN BC ON TOP FACE IN APPLYBC'
               call bl_error("stop")
            end if

         case (2)
            !
            ! The Front of the Grid
            !
            if(is_neumann(bct)) then
               do n = 1, nc
                  do j = lo(2), hi(2)
                     do i = lo(1),hi(1)
                        phi(i,j,lo(3)-1,n) = merge(
     $                       phi(i,j,lo(3),n),
     $                       phi(i,j,lo(3)-1,n),
     $                       mask(i,j,lo(3)-1) .gt. 0)
                     end do
                  end do
               end do
               if ( flagden .eq. 1 ) then
                  do j = lo(2), hi(2)
                     do i = lo(1),hi(1)
                        den(i,j,lo(3))   = 1.0D0
                     end do
                  end do
               end if
            else if (is_dirichlet(bct)) then
               x(-1) = - bcl/h(3)
               call polyInterpCoeff(xInt, x, lenz+2, coef)
               do n = 1, nc
                  if ( flagbc .eq. 1 ) then
                     do j = lo(2), hi(2)
                        do i = lo(1), hi(1)
                           phi(i,j,lo(3)-1,n) = merge(
     $                          bcval(i,j,lo(3)-1,n)*coef(-1),
     $                          phi(i,j,lo(3)-1,n),
     $                          mask(i,j,lo(3)-1) .gt. 0)
                        end do
                     end do
                  else
                     do j = lo(2), hi(2)
                        do i = lo(1), hi(1)
                           phi(i,j,lo(3)-1,n) = merge(
     $                          0.0D0,
     $                          phi(i,j,lo(3)-1,n),
     $                          mask(i,j,lo(3)-1) .gt. 0)
                        end do
                     end do
                  end if
                  do m = 0, lenz
                     do j = lo(2), hi(2)
                        do i = lo(1), hi(1)
                           phi(i, j, lo(3)-1, n) = merge(
     $                          phi(i, j, lo(3)-1,n)
     $                          + phi(i, j, lo(3)+m, n)*coef(m),
     $                          phi(i, j, lo(3)-1,n),
     $                          mask(i, j, lo(3)-1) .gt. 0)
                        end do
                     end do
                  end do
               end do
               if ( flagden .eq. 1 ) then
                  do j = lo(2), hi(2)
                     do i = lo(1), hi(1)
                        den(i, j, lo(3))   = merge(coef(0), 0.0D0,
     $                       mask(i, j, lo(3)-1) .gt. 0)
                     end do
                  end do
               end if
            else if ( bct .eq. LO_REFLECT_ODD ) then
               do n = 1, nc
                  do j = lo(2), hi(2)
                     do i = lo(1), hi(1)
                        phi(i, j, lo(3)-1, n) = merge(
     $                       -phi(i,j,lo(3),n),
     $                       phi(i,j,lo(3)-1,n),
     $                       mask(i,j,lo(3)-1) .gt. 0)
                     end do
                  end do
               end do
               if ( flagden .eq. 1 ) then
                  do j = lo(2), hi(2)
                     do i = lo(1), hi(1)
                        den(i,j,lo(3)) = merge(-1.0D0, 0.0D0,
     $                       mask(i,j,lo(3)-1) .gt. 0)
                     end do
                  end do
               end if
            else
               print *,'UNKNOWN BC ON FRONT FACE IN APPLYBC'
               call bl_error("stop")
            end if

         case (5)
            !
            ! The back of the grid
            !
            if(is_neumann(bct)) then
               do n = 1, nc
                  do j = lo(2), hi(2)
                     do i = lo(1), hi(1)
                        phi(i,j, hi(3)+1,n) = merge(
     $                       phi(i,j, hi(3),n),
     $                       phi(i,j, hi(3)+1,n),
     $                       mask(i,j, hi(3)+1) .gt. 0)
                     end do
                  end do
               end do
               if ( flagden .eq. 1 ) then
                  do j = lo(2), hi(2)
                     do i = lo(1), hi(1)
                        den(i,j, hi(3))   = 1.0D0
                     end do
                  end do
               end if
            else if (is_dirichlet(bct)) then
               x(-1) = - bcl/h(3)
               call polyInterpCoeff(xInt, x, lenz+2, coef)
               do n = 1, nc
                  if ( flagbc .eq. 1 ) then
                     do j = lo(2), hi(2)
                        do i = lo(1), hi(1)
                           phi(i,j, hi(3)+1,n) = merge(
     $                          bcval(i,j, hi(3)+1,n)*coef(-1),
     $                          phi(i,j, hi(3)+1,n),
     $                          mask(i,j, hi(3)+1) .gt. 0)
                        end do
                     end do
                  else
                     do j = lo(2), hi(2)
                        do i = lo(1), hi(1)
                           phi(i,j, hi(3)+1,n) = merge(
     $                          0.0D0,
     $                          phi(i,j, hi(3)+1,n),
     $                          mask(i,j, hi(3)+1) .gt. 0)
                        end do
                     end do
                  end if
                  do m = 0, lenz
                     do j = lo(2), hi(2)
                        do i = lo(1), hi(1)
                           phi(i, j, hi(3)+1,n) = merge(
     $                          phi(i,j, hi(3)+1,n)
     $                          + phi(i, j, hi(3)-m,n)*coef(m),
     $                          phi(i,j, hi(3)+1,n),
     $                          mask(i,j, hi(3)+1) .gt. 0)
                        end do
                     end do
                  end do
               end do
               if ( flagden .eq. 1 ) then
                  do j = lo(2), hi(2)
                     do i = lo(1), hi(1)
                        den(i,j, hi(3))   = merge(coef(0), 0.0D0,
     $                       mask(i,j, hi(3)+1) .gt. 0)
                     end do
                  end do
               end if
            else if ( bct .eq. LO_REFLECT_ODD ) then
               do n = 1, nc
                  do j = lo(2), hi(2)
                     do i = lo(1), hi(1)
                        phi(i, j, hi(3)+1, n) = merge(
     $                       -phi(i,j,hi(3),n),
     $                       phi(i,j,hi(3)+1,n),
     $                       mask(i,j,hi(3)+1) .gt. 0)
                     end do
                  end do
               end do
               if ( flagden .eq. 1 ) then
                  do j = lo(2), hi(2)
                     do i = lo(1), hi(1)
                        den(i,j,hi(3)) = merge(-1.0D0, 0.0D0,
     $                       mask(i,j,hi(3)+1) .gt. 0)
                     end do
                  end do
               end if
            else
               print *,'UNKNOWN BC ON BACK FACE IN APPLYBC'
               call bl_error("stop")
            end if
         end select

      end
