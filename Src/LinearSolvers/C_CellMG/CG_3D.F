#undef  BL_LANG_CC
#ifndef BL_LANG_FORT
#define BL_LANG_FORT
#endif

#include <REAL.H>
#include <CG_F.H>
#include <ArrayLim.H>

c-----------------------------------------------------------------------
c      
c     CGUPDATE: Modify the input arrays as follows:
c     
c     phi = phi + a*pp
c     rr  = rr  - a*ww    through range lo:hi
c     
c     phi <=>
c     rr  <=>
c     a   <=
c     ww  <=
c     pp  <=
c     
c-----------------------------------------------------------------------
      subroutine FORT_CGUPDATE(
     $     phi, DIMS(phi),
     $     rr,  DIMS(rr),
     $     a,
     $     ww,  DIMS(ww),
     $     pp,  DIMS(pp),
     $     lo, hi, nc
     $     )
      implicit none
      integer nc
      integer lo(BL_SPACEDIM)
      integer hi(BL_SPACEDIM)
      integer DIMDEC(rr)
      REAL_T rr(DIMV(rr),nc)
      integer DIMDEC(ww)
      REAL_T ww(DIMV(ww),nc)
      integer DIMDEC(pp)
      REAL_T pp(DIMV(pp),nc)
      integer DIMDEC(phi)
      REAL_T phi(DIMV(phi),nc)
      REAL_T a

      integer i,j,k,n

      do n = 1, nc
         do k = lo(3), hi(3)
            do j = lo(2), hi(2)
               do i = lo(1), hi(1)
                  phi(i,j,k,n) = phi(i,j,k,n) + a * pp(i,j,k,n)
               end do
            end do
         end do
      end do

      do n = 1, nc
         do k = lo(3), hi(3)
            do j = lo(2), hi(2)
               do i = lo(1), hi(1)
                  rr(i,j,k,n)  = rr(i,j,k,n)  - a * ww(i,j,k,n)
               end do
            end do
         end do
      end do

      end
c-----------------------------------------------------------------------
c      
c     CGADVCP: Modify the input arrays as follows:
c     
c     pp = rr + b*pp    through range lo:hi
c     
c     pp  <=>
c     rr  <=>
c     b   <=
c     
c-----------------------------------------------------------------------
      subroutine FORT_CGADVCP(
     $     pp, DIMS(pp),
     $     rr, DIMS(rr),
     $     b,
     $     lo, hi, nc
     $     )

      implicit none
      integer nc
      integer lo(BL_SPACEDIM)
      integer hi(BL_SPACEDIM)
      integer DIMDEC(rr)
      REAL_T rr(DIMV(rr),nc)
      integer DIMDEC(pp)
      REAL_T pp(DIMV(pp),nc)
      REAL_T b

      integer i,j,k,n

      do n = 1, nc
         do k = lo(3), hi(3)
            do j = lo(2), hi(2)
               do i = lo(1), hi(1)
                  pp(i,j,k,n) = rr(i,j,k,n) + b*pp(i,j,k,n)
               end do
            end do
         end do
      end do

      end
      
c-----------------------------------------------------------------------
c      
c     CGAXP: Modify the input as follows:
c     
c     pw = Transpose(pp) . ww    through range lo:hi
c     
c     pw   =>
c     pp  <=
c     ww  <=
c     
c-----------------------------------------------------------------------
      subroutine FORT_CGXDOTY(
     $     pw,
     $     pp, DIMS(pp),
     $     ww, DIMS(ww),
     $     lo, hi, nc
     $     )
      implicit none
      integer nc
      integer lo(BL_SPACEDIM)
      integer hi(BL_SPACEDIM)
      integer DIMDEC(ww)
      REAL_T ww(DIMV(ww),nc)
      integer DIMDEC(pp)
      REAL_T pp(DIMV(pp),nc)
      REAL_T pw

      integer i, j, k, n

      pw = 0.0D0

      do n = 1, nc
         do k = lo(3), hi(3)
            do j = lo(2), hi(2)
               do i = lo(1), hi(1)
                  pw = pw + pp(i,j,k,n)*ww(i,j,k,n)
               end do
            end do
         end do
      end do

      end
c-----------------------------------------------------------------------
      subroutine FORT_CGSXAY(
     $     ss, DIMS(ss),
     $     xx, DIMS(xx),
     $     a,
     $     yy, DIMS(yy),
     $     lo, hi, nc
     $     )
      implicit none
      integer nc
      integer lo(BL_SPACEDIM)
      integer hi(BL_SPACEDIM)
      integer DIMDEC(ss)
      REAL_T ss(DIMV(ss),nc)
      integer DIMDEC(xx)
      REAL_T xx(DIMV(xx),nc)
      integer DIMDEC(yy)
      REAL_T yy(DIMV(yy),nc)
      REAL_T a

      integer i, j, k, n

      do n = 1, nc
         do k = lo(3), hi(3)
            do j = lo(2), hi(2)
               do i = lo(1), hi(1)
                  ss(i,j,k,n) = xx(i,j,k,n) + a*yy(i,j,k,n)
               end do
            end do
         end do
      end do

      end
